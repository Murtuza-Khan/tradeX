import '../../resources/exports/index.dart';

class RedeemRewards extends GetView<RedeemRewardsController> {
  const RedeemRewards({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DismissKeyboard(
        child: Container(
          color: AppColors.backgroundColor,
          child: Form(
            key: controller.formKey,
            child: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      EneftyIcons.gift_outline,
                      color: AppColors.primary,
                      size: 80,
                    ),
                    const SpaceH20(),
                    Text(
                      Strings.REDEEM_POINTS_INTO,
                      style: context.headlineSmall.copyWith(
                        color: AppColors.primary,
                        fontSize: 28.0,
                      ),
                    ),
                    const SpaceH20(),
                    Text(
                      Strings.REDEEM_A_GIFTKARET,
                      style: context.titleMedium.copyWith(
                        color: AppColors.disabled,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SpaceH20(),
                    _buildAvailablePoints(context),
                    const SpaceH20(),
                    CustomTextFormField(
                      controller: controller.pointsCtrl,
                      textCapitalization: TextCapitalization.none,
                      isRequired: true,
                      height: Sizes.HEIGHT_20,
                      labelText: Strings.POINTS,
                      labelColor: AppColors.black,
                      prefixIcon: EneftyIcons.card_outline,
                      prefixIconColor: AppColors.black,
                      textColor: AppColors.black,
                      hintText: "Min 1,000",
                      cursorColor: AppColors.black,
                      enableBorderColor: AppColors.black,
                      focusBorderColor: AppColors.primary,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      autofillHints: const [AutofillHints.email],
                      onChanged: controller.onPointsChanged,
                    ),
                    SpaceH10(),
                    CustomRichText(
                      "Note : The minimum redemption threshold is",
                      style: context.titleSmall,
                      children: [
                        TextSpan(
                          text: " ${GlobalHelper.formatedNumber(value: 1000)} ",
                          style: context.titleLarge.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "points",
                          style: context.titleSmall,
                        ),
                      ],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SpaceH16(),
                    CustomButton.solid(
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.white,
                      text: Strings.PROCEED,
                      onTapAsync: () async => controller.redeemPoints(),
                      radius: Sizes.RADIUS_12,
                      constraints: const BoxConstraints(minHeight: 55),
                    ),
                    SpaceH16(),
                  ],
                ).paddingSymmetric(horizontal: 16.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvailablePoints(BuildContext context) {
    return CustomFutureBuilder(
      future: RedeemRewardsRepository.userPoints(),
      customLoader: CustomLoading.spinKitThreeBouncePrimary,
      data: (userPoints) {
        controller.userPoints = userPoints ?? UserPoints();
        controller.points.value =
            (controller.userPoints.awardedPoints?.value ?? 0) -
                (controller.userPoints.redeemedPoints?.value ?? 0);
      },
      hasDataBuilder: (_, __) {
        return Obx(
          () => CustomRichText(
            "Available Points : ",
            style: context.titleLarge.copyWith(
              color: AppColors.secondary,
            ),
            children: [
              TextSpan(
                text: GlobalHelper.formatedNumber(
                  value: controller.points.value,
                ),
                style: context.headlineSmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
