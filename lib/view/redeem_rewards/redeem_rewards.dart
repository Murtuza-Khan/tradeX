import '../../resources/exports/index.dart';

class RedeemRewards extends GetView<RedeemRewardsController> {
  const RedeemRewards({super.key});

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
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
                  Center(
                    child: Icon(
                      EneftyIcons.gift_outline,
                      color: AppColors.primary,
                      size: 80,
                    ),
                  ),
                  const SpaceH20(),
                  Text(
                    Strings.REDEEM_POINTS_INTO,
                    style: context.headlineSmall
                        .copyWith(color: AppColors.primary),
                  ),
                  CustomRichText(
                    Strings.YOU_MAY_CONVERT,
                    style: context.labelLarge.copyWith(fontSize: 13),
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            CustomDialog.showFullScreenDialog(
                              content: _buildInfoDialogContent(context),
                            );
                          },
                          child: Text(
                            Strings.CLICK_HERE,
                            style: context.titleMedium.copyWith(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primary,
                            ),
                          ),
                        ),
                      )
                    ],
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                  SpaceH10(),
                  CustomRichText(
                    Strings.PLEASE_SELECT_THE,
                    style: context.labelLarge.copyWith(fontSize: 13),
                    children: [
                      TextSpan(
                        text: Strings.REDEEM_NOW,
                        style: context.titleMedium
                            .copyWith(color: AppColors.primary),
                      ),
                      TextSpan(
                        text: Strings.BUTTON,
                        style: context.labelLarge.copyWith(fontSize: 13),
                      ),
                    ],
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                  const SpaceH12(),
                  _buildAvailablePoints(context),
                  const SpaceH12(),
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
                    validator: (value) {
                      if (value == null) return null;
                      if (int.parse(value) >
                          ((controller.userPoints.awardedPoints?.value ?? 0) -
                              (controller.userPoints.redeemedPoints?.value ??
                                  0))) {
                        controller.points.value = 0;
                        return "Points can't be grater than ${GlobalHelper.formatedNumber(value: (controller.userPoints.awardedPoints?.value ?? 0) - (controller.userPoints.redeemedPoints?.value ?? 0))}";
                      } else {}
                      return null;
                    },
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
                    text: Strings.REDEEME,
                    onTapAsync: () async => controller.redeemPoints(),
                    radius: Sizes.RADIUS_12,
                    constraints: const BoxConstraints(minHeight: 55),
                  ),
                  SpaceH96(),
                ],
              ).paddingSymmetric(horizontal: 16.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoDialogContent(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.white,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              Image.asset(
                Assets.REDEEM_INFO,
                fit: BoxFit.fill,
                height: 700,
              ),
              SpaceH20(),
              CustomRichText(
                "${Strings.CLICK} ",
                style: context.titleMedium.copyWith(fontSize: 13),
                children: [
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () => GlobalHelper.launch(
                        "https://www.giftkarte.com/vendors/instore",
                      ),
                      child: Text(
                        Strings.HERE,
                        style: context.titleLarge.copyWith(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  TextSpan(
                    text: " ${Strings.FOR_COMPLETE}",
                    style: context.titleMedium.copyWith(fontSize: 13),
                  ),
                ],
                maxLines: 3,
              ).paddingSymmetric(horizontal: 16.0),
              SpaceH20(),
              CustomButton.solid(
                backgroundColor: AppColors.primary,
                textColor: AppColors.white,
                text: Strings.CONTINUE,
                onTap: () => Get.back(),
                radius: Sizes.RADIUS_12,
                constraints: const BoxConstraints(minHeight: 55),
              ).paddingSymmetric(horizontal: 16.0),
              SpaceH20(),
            ],
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
