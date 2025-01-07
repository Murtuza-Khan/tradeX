import '../../../resources/exports/index.dart';

class RedeemPointsDialogContent extends GetView<RedeemRewardsController> {
  final RedeemHistory points;

  const RedeemPointsDialogContent({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<RedeemRewardsController>(
              id: 'update_success_icon',
              builder: (controller) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) {
                    return RotationTransition(
                      turns: child.key == const ValueKey('icon1')
                          ? Tween<double>(begin: 0.75, end: 1).animate(anim)
                          : Tween<double>(begin: 1.25, end: 1).animate(anim),
                      child: FadeTransition(opacity: anim, child: child),
                    );
                  },
                  child: controller.currentIndex == 0
                      ? Icon(
                          key: const ValueKey('icon1'),
                          EneftyIcons.tick_circle_outline,
                          color: AppColors.success,
                          size: 85,
                        )
                      : Icon(
                          key: const ValueKey('icon2'),
                          EneftyIcons.gift_outline,
                          color: AppColors.primary,
                          size: 85,
                        ),
                );
              },
            ),
            SpaceH20(),
            CustomRichText(
              "Your voucher ",
              style: context.titleLarge.copyWith(
                fontSize: 21,
                fontWeight: FontWeight.normal,
              ),
              children: [
                TextSpan(
                  text: "${points.voucherCode}",
                  style: context.titleLarge.copyWith(
                    color: AppColors.primary,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: " was successfully redeemed on ",
                  style: context.titleLarge.copyWith(
                    fontSize: 21,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text:
                      "${points.createdDate?.format(pattern: "MMMM dd, yyyy")}",
                  style: context.titleLarge.copyWith(
                    color: AppColors.primary,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: " at ${points.createdDate?.format(pattern: "hh:mm a")}",
                  style: context.titleLarge.copyWith(
                    color: AppColors.primary,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              maxLines: 4,
              textAlign: TextAlign.center,
            ),
            SpaceH20(),
            CustomButton.solid(
              backgroundColor: AppColors.primary,
              textColor: AppColors.white,
              text: Strings.DONE,
              onTap: () {
                Get.close(1);
                LandingController.instance.onNavigate(0, Routes.HOME);
              },
              radius: Sizes.RADIUS_12,
              constraints: const BoxConstraints(minHeight: 55),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.0),
      ),
    );
  }
}
