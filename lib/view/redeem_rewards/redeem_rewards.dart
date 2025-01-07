import '../../resources/exports/index.dart';

class RedeemRewards extends GetView<RedeemRewardsController> {
  const RedeemRewards({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DismissKeyboard(
        child: Container(
          color: AppColors.background,
          child: Form(
            key: controller.formKey,
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
                CustomTextFormField(
                  controller: controller.pointsCtrl,
                  fillColor: AppColors.white,
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
                ),
                SpaceH20(),
                CustomButton.solid(
                  backgroundColor: AppColors.primary,
                  textColor: AppColors.white,
                  text: Strings.PROCEED,
                  onTapAsync: () async => controller.redeemPoints(),
                  radius: Sizes.RADIUS_12,
                  constraints: const BoxConstraints(minHeight: 55),
                ),
              ],
            ).paddingSymmetric(horizontal: 16.0),
          ),
        ),
      ),
    );
  }
}
