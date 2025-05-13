import '../../../resources/exports/index.dart';

class NotificationsController extends GetxController {
  late PagingController pagingCtrl;
  List<NotificationModel> notifications = [];

  Future<void> onReadAll() async {
    ApiResult result = await NotificationRepository.readAllNotifications();
    if (result == ApiResult.success) {
      LandingController.instance.getNotificationCount();
      pagingCtrl.itemList?.clear();
      pagingCtrl.refresh();
    }
  }
}
 