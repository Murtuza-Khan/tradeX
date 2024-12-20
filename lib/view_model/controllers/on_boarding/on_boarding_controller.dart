import '../../../resources/exports/index.dart';

class OnBoardingController extends GetxController {
  late List<OnBoardingModel> onBoardingItems;
  late PageController pageCtrl;

  int selectedIndex = 0;

  Future<void> onStartGifting() async {
    bool isViewed = AuthManager.instance.getIntroViewInfo() ?? false;
    if (!isViewed) await AuthManager.instance.saveIntroViewInfo(true);
    if (Get.previousRoute.isEmpty) {
      Get.offAllNamed(Routes.LANDING);
    } else {
      Get.back();
    }
  }

  void onNextTap(int index) {
    selectedIndex = index;
    if (pageCtrl.hasClients) {
      pageCtrl.animateToPage(
        index,
        duration: Durations.short2,
        curve: Curves.linear,
      );
    }

    update(['on_boarding_bottom_nav_bar']);
  }

  @override
  void onInit() {
    pageCtrl = PageController(initialPage: 0);
    onBoardingItems = [
      OnBoardingModel(
        title: Strings.OPEN_DATA_SETTINGS,
        subTitle: Strings.REWARDZONE_BRINGS,
        image:
            "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/0a/ed/a4/0aeda4e5-66f9-1c39-7395-8c3e361682fb/d470b212-5eaf-4a45-b533-110d55e9c10d_Flowers.jpg/300x0w.jpg",
      ),
      OnBoardingModel(
        title: Strings.UNLOCK_REWARDS,
        subTitle: Strings.CLAIMIT_MAKES,
        image:
            "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/0a/ed/a4/0aeda4e5-66f9-1c39-7395-8c3e361682fb/d470b212-5eaf-4a45-b533-110d55e9c10d_Flowers.jpg/300x0w.jpg",
      ),
      OnBoardingModel(
        title: Strings.DISCOVER_AND_REDEEM,
        subTitle: Strings.WITH_PERKPOINT,
        image:
            "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/0a/ed/a4/0aeda4e5-66f9-1c39-7395-8c3e361682fb/d470b212-5eaf-4a45-b533-110d55e9c10d_Flowers.jpg/300x0w.jpg",
      ),
    ];
    super.onInit();
  }
}
