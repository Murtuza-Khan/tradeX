import '../../../resources/exports/index.dart';

class PasswordResetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PasswordResetController());
  }
}
