import '../resources/exports/index.dart';

class NotificationRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<int> getNotificationCount() async {
    final response = await apiService.getApi(Urls.UNREAD_COUNT);
    if (response is bool) return 0;
    return response['unread_count'];
  }
  
  static Future<ApiResult> readAllNotifications() async {
    final response = await apiService.postApi(Urls.READ_ALL);
    if (response is bool) return ApiResult.fail;
    return ApiResult.success;
  }
}
