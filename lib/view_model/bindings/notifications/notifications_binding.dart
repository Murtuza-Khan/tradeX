import '../../../resources/exports/index.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationsController(), permanent: true);
  }
}