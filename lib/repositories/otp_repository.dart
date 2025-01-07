import '../resources/exports/index.dart';

class OtpRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<(ApiResult, String token)> verifyOtp({
    required Map<String, dynamic> data,
  }) async {
    final response = await apiService.postApi(Urls.VERIFY_OTP, body: data);
    if (response is bool) return (ApiResult.fail, '');
    return (ApiResult.success, response['token'] as String);
  }
}
