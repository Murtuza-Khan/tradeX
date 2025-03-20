import '../../../resources/exports/index.dart';

class RedeemRewardsHistoryController extends GetxController {
  Future<void> onConfirmDeepLinkTap() async {
    Get.close(1);
    await launchUrl(
      Uri.parse("https://giftkarte.com/received_e_gift_cards"),
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> onCancleDeepLinkTap() async {
    Get.close(1);
    if (Platform.isAndroid) {
      const androidPackage = "com.ionic.giftkarte";
      final url = Uri.parse(
        "https://play.google.com/store/apps/details?id=$androidPackage",
      );
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      final appId = "1521130210";
      final url = Uri.parse("https://apps.apple.com/app/id$appId");
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}
 