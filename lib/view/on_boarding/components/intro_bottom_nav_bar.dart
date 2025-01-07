import '../../../resources/exports/index.dart';

class IntroBottomNavBar extends GetView<OnBoardingController> {
  const IntroBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(
      id: 'on_boarding_bottom_nav_bar',
      builder: (_) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                controller.selectedIndex != 3
                    ? GestureDetector(
                        onTap: () => controller.onStartGifting(),
                        child: Container(
                          color: AppColors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 10,
                          ),
                          child: IgnorePointer(
                            ignoring: true,
                            child: Text(
                              Strings.SKIP,
                              style: context.titleMedium.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SpaceW12(),
                AnimatedSmoothIndicator(
                  activeIndex: controller.selectedIndex,
                  count: 4,
                  axisDirection: Axis.horizontal,
                  effect: ExpandingDotsEffect(
                    spacing: 8.0,
                    radius: 4.0,
                    dotWidth: 6.0,
                    dotHeight: 6.0,
                    dotColor: Colors.grey,
                    activeDotColor: AppColors.primary,
                  ),
                ),
                const SpaceW12(),
                controller.selectedIndex != 3
                    ? GestureDetector(
                        onTap: () => controller.pageCtrl.nextPage(
                          duration: Durations.medium3,
                          curve: Curves.linear,
                        ),
                        child: Container(
                          color: AppColors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 16,
                          ),
                          child: IgnorePointer(
                            ignoring: true,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () => controller.onStartGifting(),
                        child: Container(
                          color: AppColors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 10,
                          ),
                          child: IgnorePointer(
                            ignoring: true,
                            child: Text(
                              Strings.DONE,
                              style: context.titleMedium.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ).paddingOnly(left: 30.0, right: 18),
            const SpaceH6(),
            controller.selectedIndex != 3
                ? _buildAnimatedBar()
                : _buildStartGiftingButton(context).paddingSymmetric(
                    horizontal: 26.0,
                  ),
            const SpaceH20(),
          ],
        ).constrainedBox(
          maxHeight: controller.selectedIndex != 3 ? 100 : 135,
          maxWidth: Get.width,
        );
      },
    );
  }

  Widget _buildStartGiftingButton(BuildContext context) {
    return CustomButton.solid(
      backgroundColor: AppColors.primaryLight,
      textStyle: context.titleLarge.copyWith(color: AppColors.primary),
      text: Strings.CONTINUE,
      onTapAsync: () async => controller.onStartGifting(),
      radius: Sizes.RADIUS_32,
      hasInfiniteWidth: false,
      constraints: BoxConstraints(
        minHeight: 55,
        maxWidth: Get.width,
        minWidth: Get.width,
      ),
    ).shadow();
  }

  Stack _buildAnimatedBar() {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: 5.0,
          decoration: const BoxDecoration(color: AppColors.primaryLight),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            width: (Get.width / 3) * controller.selectedIndex,
            height: 5.0,
            duration: Durations.medium3,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
            ),
          ),
        )
      ],
    );
  }
}
