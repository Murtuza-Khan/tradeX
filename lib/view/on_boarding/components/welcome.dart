import '../../../resources/exports/index.dart';

class Welcome extends GetView<OnBoardingController> {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ImageService.image(
              imageHeight: 500,
              borderRadius: 12,
              fit: BoxFit.contain,
              "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource221/v4/0a/ed/a4/0aeda4e5-66f9-1c39-7395-8c3e361682fb/d470b212-5eaf-4a45-b533-110d55e9c10d_Flowers.jpg/300x0w.jpg",
            ),
            Text(
              Strings.OPEN_DATA_SETTINGS,
              style: context.headlineSmall.copyWith(fontSize: 30.0),
              textAlign: TextAlign.center,
            ).paddingSymmetric(horizontal: 16.0),
            const SpaceH20(),
            Text(
              Strings.REWARDZONE_BRINGS,
              style: context.titleMedium.copyWith(fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ).paddingSymmetric(horizontal: 16.0),
          ],
        ),
      ),
    );
  }
}
