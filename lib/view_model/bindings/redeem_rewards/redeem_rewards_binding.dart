import '../../../resources/exports/index.dart';

class RedeemRewardsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RedeemRewardsController(), fenix: true);
  }
}
