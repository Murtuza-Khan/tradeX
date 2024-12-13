import '../../resources/exports/index.dart';

class PasswordReset extends GetView<PasswordResetController> {
  const PasswordReset({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.RESET_PASSWORD),
      body: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.RESET_PASSWORD.tr,
              style: context.headlineLarge.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            const SpaceH4(),
            Text(
              Strings.FILL_THE_DETAILS.tr,
              style: context.titleMedium.copyWith(
                color: AppColors.greyShade2,
              ),
            ),
            const SpaceH20(),
            Obx(
              () => CustomTextFormField(
                controller: controller.newPasswordCtrl,
                isRequired: true,
                textCapitalization: TextCapitalization.none,
                height: Sizes.HEIGHT_20,
                obscureText: !controller.isNewPasswordVisible.value,
                labelText: Strings.NEW_PASSWORD,
                labelColor: AppColors.black,
                prefixIcon: EneftyIcons.lock_outline,
                prefixIconColor: AppColors.black,
                textColor: AppColors.black,
                cursorColor: AppColors.black,
                enableBorderColor: AppColors.black,
                focusBorderColor: AppColors.primary,
                suffixIconColor: AppColors.black,
                suffixIcon: controller.isNewPasswordVisible.value
                    ? EneftyIcons.eye_slash_outline
                    : EneftyIcons.eye_outline,
                onSuffixTap: controller.toggleNewPassword,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
                keyboardType: TextInputType.text,
                inputFormatters: InputFormat.denySpace,
                onFieldSubmit: (s) {},
              ),
            ),
            const SpaceH10(),
            Obx(
              () => CustomTextFormField(
                controller: controller.confirmPasswordCtrl,
                isRequired: true,
                textCapitalization: TextCapitalization.none,
                height: Sizes.HEIGHT_20,
                obscureText: !controller.isConfirmPasswordVisible.value,
                labelText: Strings.CONFIRM_PASSWORD,
                labelColor: AppColors.black,
                prefixIcon: EneftyIcons.lock_outline,
                prefixIconColor: AppColors.black,
                textColor: AppColors.black,
                cursorColor: AppColors.black,
                enableBorderColor: AppColors.black,
                focusBorderColor: AppColors.primary,
                suffixIconColor: AppColors.black,
                suffixIcon: controller.isConfirmPasswordVisible.value
                    ? EneftyIcons.eye_slash_outline
                    : EneftyIcons.eye_outline,
                onSuffixTap: controller.toggleConfirmPassword,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
                keyboardType: TextInputType.text,
                inputFormatters: InputFormat.denySpace,
                onFieldSubmit: (s) {},
              ),
            ),
            const SpaceH20(),
            CustomButton.solid(
              backgroundColor: AppColors.primary,
              textColor: AppColors.white,
              text: Strings.CONFIRM,
              onTapAsync: () async => controller.onConfirm(),
              radius: Sizes.RADIUS_12,
              constraints: const BoxConstraints(minHeight: 55),
            ),
          ],
        ).paddingAll(16.0),
      ),
    );
  }
}
