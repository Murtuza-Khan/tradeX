import '../../resources/exports/index.dart';

class OnBoarding extends GetView<OnBoardingController> {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      headerBackgroundColor: AppColors.white,
      totalPage: 3,
      speed: 1.8,
      finishButtonText: Strings.PROCEED,
      finishButtonTextStyle: context.titleLarge.copyWith(
        color: AppColors.white,
      ),
      onFinish: () async {
        await AuthManager.instance.saveIntroViewInfo(true);
        Get.offAllNamed(Routes.LOGIN);
      },
      background: controller.onBoardingItems.map((e) => SizedBox()).toList(),
      pageBodies: controller.onBoardingItems
          .map(
            (e) => Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              color: Colors.transparent,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ImageService.image(
                      e.image,
                      imageHeight: Get.height * 0.6,
                      fit: BoxFit.contain,
                      borderRadius: 12.0
                    ),
                    SpaceH30(),
                    Text(
                      e.title,
                      style: context.headlineSmall,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SpaceH10(),
                    Text(
                      e.subTitle,
                      style: context.labelMedium.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
