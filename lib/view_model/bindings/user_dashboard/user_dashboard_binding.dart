import '../../../resources/exports/index.dart';

class UserDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserDashboardController(), fenix: true);
  }
}
