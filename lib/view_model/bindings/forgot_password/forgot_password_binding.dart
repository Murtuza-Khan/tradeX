import '../../../resources/exports/index.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordController());
  }
}
