import '../../../resources/exports/index.dart';

class OnBoardingController extends GetxController {
  late List<OnBoardingModel> onBoardingItems;

  @override
  void onInit() {
    onBoardingItems = [
      OnBoardingModel(
        title: Strings.OPEN_DATA_SETTINGS,
        subTitle: Strings.REWARDZONE_BRINGS,
        image: "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/0a/ed/a4/0aeda4e5-66f9-1c39-7395-8c3e361682fb/d470b212-5eaf-4a45-b533-110d55e9c10d_Flowers.jpg/300x0w.jpg",
      ),
      OnBoardingModel(
        title: Strings.UNLOCK_REWARDS,
        subTitle: Strings.CLAIMIT_MAKES,
        image: "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/0a/ed/a4/0aeda4e5-66f9-1c39-7395-8c3e361682fb/d470b212-5eaf-4a45-b533-110d55e9c10d_Flowers.jpg/300x0w.jpg",
      ),
      OnBoardingModel(
        title: Strings.DISCOVER_AND_REDEEM,
        subTitle: Strings.WITH_PERKPOINT,
        image: "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/0a/ed/a4/0aeda4e5-66f9-1c39-7395-8c3e361682fb/d470b212-5eaf-4a45-b533-110d55e9c10d_Flowers.jpg/300x0w.jpg",
      ),
    ];
    super.onInit();
  }
}
