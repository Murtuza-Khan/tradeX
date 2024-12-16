import '../../../resources/exports/index.dart';

class SwitchAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SwitchAccountController());
  }
}
