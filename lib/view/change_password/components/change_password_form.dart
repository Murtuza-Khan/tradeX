import '../../../resources/exports/index.dart';

class ChangePasswordForm extends GetView<ChangePasswordController> {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          Obx(
            () => CustomTextFormField(
              controller: controller.oldPassCtrl,
              isRequired: true,
              textCapitalization: TextCapitalization.none,
              height: Sizes.HEIGHT_20,
              obscureText: !controller.isOldPasswordVisible.value,
              labelText: Strings.OLD_PASSWORD,
              labelColor: AppColors.black,
              prefixIcon: EneftyIcons.lock_outline,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primary,
              suffixIconColor: AppColors.black,
              suffixIcon: controller.isOldPasswordVisible.value
                  ? EneftyIcons.eye_slash_outline
                  : EneftyIcons.eye_outline,
              onSuffixTap: controller.toggleOldPassword,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              keyboardType: TextInputType.text,
              inputFormatters: InputFormat.denySpace,
              onFieldSubmit: (s) {},
            ),
          ),
          SpaceH8(),
          Obx(
            () => CustomTextFormField(
              controller: controller.newPassCtrl,
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
          SpaceH8(),
          Obx(
            () => CustomTextFormField(
              controller: controller.confirmPassCtrl,
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
        ],
      ),
    );
  }
}
