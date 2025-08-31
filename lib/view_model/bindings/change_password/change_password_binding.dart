import '../../../resources/exports/index.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordController());
  }
}
