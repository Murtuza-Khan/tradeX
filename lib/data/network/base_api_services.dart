import '../../resources/exports/index.dart';

abstract class BaseApiServices {
  Future getApi(
    String url, {
    Map<String, dynamic>? queryParameters,
    bool addEncryption = false,
  });

  Future postApi(
    String url, {
    Map<String, dynamic>? body,
    bool? returnResponse,
    bool addEncryption = false,
  });

  Future multiPartApi(
    String url, {
    Map<String, List<XFile>>? files,
    Map<String, dynamic>? data,
    bool addEncryption = false,
  });
}
