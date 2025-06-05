import '../../../resources/exports/index.dart';

class RedeemRewardsController extends GetxController {
  late GlobalKey<FormState> formKey;
  late TextEditingController pointsCtrl;

  UserPoints userPoints = UserPoints();

  int currentIndex = 0;
  RxInt points = 0.obs;

  String get getButtonText => pointsCtrl.text.isNotEmpty &&
          pointsCtrl.text != "0"
      ? "( ${convertPointsIntoPkr().getNumFormattedCurrency()} ) ${Strings.REDEEM_NOW}"
      : Strings.REDEEM_NOW;

  num convertPointsIntoPkr() {
    return pointsCtrl.text.toInt() * (userPoints.pointsToPkr ?? 0);
  }

  Future<void> onDeepLinkTap() async {
    if (Platform.isAndroid) {
      final appCheck = AppCheck();
      const androidPackage = "com.ionic.giftkarte";
      AppInfo? info = await appCheck
          .checkAvailability(androidPackage)
          .onError((e, st) => null);

      if (info == null) {
        await launchUrl(
          Uri.parse(
            "https://play.google.com/store/apps/details?id=$androidPackage",
          ),
          mode: LaunchMode.externalApplication,
        );
      } else {
        await launchUrl(
          Uri.parse("https://giftkarte.com/received_e_gift_cards"),
          mode: LaunchMode.externalApplication,
        );
      }
    } else {
      await launchUrl(
        Uri.parse("https://giftkarte.com/received_e_gift_cards"),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  void onPointsChanged(String? value) {
    points.value = (userPoints.awardedPoints?.value ?? 0) -
        (userPoints.redeemedPoints?.value ?? 0);
    if (formKey.currentState?.validate() ?? false) {
      if ((value ?? "").isEmpty) return;
      points.value = points.value - int.parse(value ?? "0");
    }
    update(['redeem_btn']);
  }

  Future<void> redeemPoints() async {
    if (formKey.currentState?.validate() ?? false) {
      CustomDialog.showConfirmationDialog(
        message: "Are you sure you want to redeem ${pointsCtrl.text} points ?",
        onTapConfirm: () async {
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
              height: 350,
              width: double.maxFinite,
              barrierDismissible: false,
              content: RedeemPointsDialogContent(points: redeemVoucher),
            );
          }
        },
      );
    }
  }

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    pointsCtrl = TextEditingController();
    super.onInit();
  }
}
