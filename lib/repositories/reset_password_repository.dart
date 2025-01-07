import '../resources/exports/index.dart';

class ResetPasswordRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<ApiResult> resetPassword({
    required Map<String, dynamic> data,
    required String? token,
  }) async {
    final response = await apiService.postApi(
      Urls.RESET_PASSWORD,
      body: data,
      token: token,
    );

    if (response is bool) return ApiResult.fail;
    AuthManager.instance.rememberCredentials.value = true;
    Session session = Session.fromJson(response);
    await AuthManager.instance.login(session);
    return ApiResult.success;
  }
}
