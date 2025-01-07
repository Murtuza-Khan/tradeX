import '../resources/exports/index.dart';

class ChangePasswordRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<ApiResult> changePassword({
    required Map<String, dynamic> data,
  }) async {
    final response = await apiService.putApi(Urls.CHANGE_PASSWORD, body: data);
    if (response is bool) return ApiResult.fail;
    return ApiResult.success;
  }
}
