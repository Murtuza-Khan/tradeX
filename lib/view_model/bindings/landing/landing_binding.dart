import '../../../resources/exports/index.dart';

class LandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandingController(), fenix: true);
  }
}
