import '../resources/exports/index.dart';

class AuthRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<ApiResult> login({
    required String cnic,
    required String password,
  }) async {
    final response = await apiService.postApi(
      Urls.LOGIN,
      returnResponse: true,
      body: {"cnic": cnic, "password": password},
    );

    if (!(response as ApiResponse).status) {
      Map<String, dynamic> errorData = response.successContents ?? {};
      if (errorData.isEmpty) {
        CustomSnackBar.errorSnackBar(
          message: response.message ?? Strings.SOMETHING_WENT_WRONG,
        );
      } else {
        CustomSnackBar.errorSnackBar(message: errorData.entries.first.value);
      }
      return ApiResult.fail;
    }

    Session session = Session.fromJson(response.successContents);
    session.appColors = AppColorsModel.fromMap(
      {
        "primary_color": "#c66f16",
        "secondary_color": "#000000",
        "tertiary_color": "#FFFFFF",
        "background_color": "#F4F7FE"
      },
    );
    await AuthManager.instance.login(session);
    return ApiResult.success;
  }

  static Future<(ApiResult, int?)> sendOtp({
    required String mobile,
  }) async {
    final response = await apiService.postApi(
      Urls.SEND_OTP,
      body: {"mobile": mobile},
      returnResponse: true,
    );

    if (!(response as ApiResponse).status) {
      final errorData = response.successContents ?? {};
      CustomSnackBar.errorSnackBar(message: errorData.entries.first.value);
      return (ApiResult.fail, null);
    }
    return (ApiResult.success, response.successContents['otp'] as int);
  }

  static Future<List<UserMobileNumbers>> forgetPassword({
    required String cnic,
  }) async {
    final response = await apiService.postApi(
      Urls.FORGET_PASSWORD,
      body: {"cnic": cnic},
    );
    if (response is bool) [];
    return UserMobileNumbers.listFromJson(response);
  }
}
