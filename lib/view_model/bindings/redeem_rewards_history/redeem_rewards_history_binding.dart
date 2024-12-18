import '../../../resources/exports/index.dart';

class RedeemRewardsHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RedeemRewardsHistoryController());
  }
}
