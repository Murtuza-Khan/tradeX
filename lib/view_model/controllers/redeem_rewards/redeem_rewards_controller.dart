import '../../../resources/exports/index.dart';

class RedeemRewardsController extends GetxController {
  late GlobalKey<FormState> formKey;
  late TextEditingController pointsCtrl;

  int currentIndex = 0;

  Future<void> redeemPoints() async {
    if (formKey.currentState?.validate() ?? false) {
      RedeemHistory? redeemVoucher =
          await RedeemRewardsRepository.redeemPoints(
        data: {
          "account_id": AuthManager.instance.company.id,
          "points": pointsCtrl.text,
        },
      );
      if (redeemVoucher != null) {
        Future.delayed(Duration(milliseconds: 700), () {
          currentIndex = 1;
          update(['update_success_icon']);
        });
        CustomDialog.showDialog(
          height: 300,
          width: double.maxFinite,
          barrierDismissible: false,
          content: RedeemPointsDialogContent(points: redeemVoucher),
        );
      }
    }
  }

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    pointsCtrl = TextEditingController();
    super.onInit();
  }
}
