import 'package:tradex/dummy/profile_data.dart';
import '../resources/exports/index.dart';

class ProfileRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<ApiResult> updateProfile({
    required Map<String, dynamic> data,
  }) async {
    final response = await apiService.putApi(Urls.UPDATE_PROFILE, body: data);
    if (response is bool) return ApiResult.fail;
    return ApiResult.success;
  }
}
