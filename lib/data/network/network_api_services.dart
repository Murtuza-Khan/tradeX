import '../../resources/exports/index.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  Map<String, String> generateHeaders() {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'AppToken': dotenv.get('appToken'),
      if (AuthManager.instance.session.value?.token == null) ...{
        'UserID': "",
        'Authorization': '',
      } else ...{
        'Authorization':
            'Bearer ${AuthManager.instance.session.value?.token ?? ""}',
        // 'Authorization':
        //     'Bearer 2074|nRAvVAhKOSz6hqJ0dteXn9ZVRfo5QZedAVSLe25k256a9c2f',
      },
    };
    return headers;
  }

  void _checkTokenValidation(http.Response response) {
    if (response.statusCode == 401) {
      AuthManager.instance.logout();
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  Future multiPartApi(
    String url, {
    Map<String, List<XFile>>? files,
    Map<String, dynamic>? data,
    bool addEncryption = false,
  }) async {
    Map<String, String>? stringData = {};
    try {
      http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.https(dotenv.get('BASE_URL'), url),
      );
      request.headers.addAll(generateHeaders());

      if (files != null && files.isNotEmpty) {
        for (int i = 0; i < files.length; i++) {
          for (int j = 0; j < files.values.length; j++) {
            if (kIsWeb) {
              final unitData = await files.values.elementAt(i)[j].readAsBytes();
              request.files.add(
                http.MultipartFile.fromBytes(
                  files.keys.elementAt(i),
                  List<int>.from(unitData),
                  filename: files.keys.elementAt(i),
                ),
              );
            } else {
              String path = files.values.elementAt(i)[j].path;
              request.files.add(
                await http.MultipartFile.fromPath(
                  files.keys.elementAt(i),
                  path,
                ),
              );
            }
          }
        }
      }

      for (int i = 0; i < (data ?? {}).keys.length; i++) {
        if (data!.values.elementAt(i) is List) {
          for (int j = 0; j < data.values.elementAt(i).length; j++) {
            stringData["${data.keys.elementAt(i)}[$j]"] =
                data.values.elementAt(i)[j].toString();
          }
        } else {
          stringData[data.keys.elementAt(i)] =
              data.values.elementAt(i).toString();
        }
      }

      MacLog.printG(stringData);

      if (data != null || data!.isNotEmpty) request.fields.addAll(stringData);
      final responseData = await request.send();
      final response = await http.Response.fromStream(responseData).timeout(
        const Duration(seconds: 60),
      );

      _checkTokenValidation(response);

      if (response.statusCode == 200) {
        dynamic responseJson = jsonDecode(response.body);
        ApiResponse data = ApiResponse.fromJson(responseJson);
        return data.successContents;
      } else {
        validateResponse(response);
        return false;
      }
    } on SocketException {
      return CustomSnackBar.offline;
    } catch (e) {
      MacLog.printR("THIS IS ERROR : $e");
      return false;
    }
  }

  @override
  Future postApi(
    String url, {
    Map<String, dynamic>? body,
    bool? returnResponse,
    bool addEncryption = false,
  }) async {
    try {
      Map<String, dynamic>? data;
      if (addEncryption) {
        String encryptedData = GlobalHelper.encrypt(body);
        MacLog.printR("ENCRYPTED DATA :: $encryptedData");
        data = {'encrypted_data': encryptedData};
      } else {
        data = body;
      }

      http.Response response = await http
          .post(
            Uri.https(dotenv.get('BASE_URL'), url),
            headers: generateHeaders(),
            body: data != null ? jsonEncode(data) : null,
          )
          .timeout(const Duration(seconds: 60));

      _checkTokenValidation(response);

      if (returnResponse ?? false) {
        Map<String, dynamic> data = jsonDecode(response.body);
        String key = data.keys.firstWhere(
          (element) => element == "data",
          orElse: () => "",
        );
        if (key.isEmpty) {
          return CustomSnackBar.errorSnackBar(message: data['message']);
        }

        dynamic decodedData = jsonDecode(response.body);
        ApiResponse result = ApiResponse.fromJson(decodedData);

        if (addEncryption) {
          dynamic decryptedData = GlobalHelper.decrypt(result.successContents);
          result.successContents = decryptedData;
        }

        return result;
      }

      if (response.statusCode == 200) {
        dynamic responseJson = jsonDecode(response.body);
        ApiResponse result = ApiResponse.fromJson(responseJson);
        if (addEncryption) {
          dynamic decryptedData = GlobalHelper.decrypt(result.successContents);
          MacLog.printG("DECRYPTED DATA :: ${decryptedData.toString()}");
          result.successContents = decryptedData;
        }
        return result.successContents;
      } else {
        validateResponse(response);
        return false;
      }
    } on SocketException {
      return CustomSnackBar.offline;
    } catch (e) {
      return false;
    }
  }

  @override
  Future getApi(
    String url, {
    Map<String, dynamic>? queryParameters,
    bool addEncryption = false,
  }) async {
    try {
      Uri uri;

      Map<String, dynamic>? data;
      if (addEncryption && queryParameters != null) {
        String encryptedData = GlobalHelper.encrypt(queryParameters);
        data = {'encrypted_data': encryptedData};
      } else {
        data = queryParameters;
      }

      if (data != null) {
        uri = Uri.https(
          dotenv.get('BASE_URL'),
          url,
          data.map((key, value) => MapEntry(key, value.toString())),
        );
      } else {
        uri = Uri.https(dotenv.get('BASE_URL'), url);
      }

      http.Response response =
          await http.get(uri, headers: generateHeaders()).timeout(
                const Duration(seconds: 60),
              );

      _checkTokenValidation(response);

      if (response.statusCode == 200) {
        dynamic responseJson = jsonDecode(response.body);
        ApiResponse result = ApiResponse.fromJson(responseJson);

        if (addEncryption) {
          dynamic decryptedData = GlobalHelper.decrypt(result.successContents);
          result.successContents = decryptedData;
        }
        return result.successContents;
      } else {
        validateResponse(response);
        return false;
      }
    } on SocketException {
      return CustomSnackBar.offline;
    } catch (e) {
      MacLog.printR("This is Error :: $e");
      return false;
    }
  }

  dynamic validateResponse(http.Response response) {
    switch (response.statusCode) {
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        CustomSnackBar.errorSnackBar(message: responseJson['message']);
        throw InvalidUrlException();
      case 403:
        CustomSnackBar.errorSnackBar(message: RestrictedAccess().message);
        throw RestrictedAccess();
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        CustomSnackBar.errorSnackBar(message: responseJson['message']);
        throw UnauthorizedException();
      case 305:
        CustomSnackBar.errorSnackBar(message: InvalidTokenException().message);
        throw InvalidTokenException();
      case 408:
        CustomSnackBar.errorSnackBar(message: RequestTimeout().message);
        throw RequestTimeout();
      case 500:
        CustomSnackBar.errorSnackBar(message: ServerException().message);
        throw ServerException();
      default:
        dynamic responseJson = jsonDecode(response.body);
        CustomSnackBar.errorSnackBar(message: responseJson['message']);
        throw UnknownError();
    }
  }
}
