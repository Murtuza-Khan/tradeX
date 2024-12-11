import '../../../resources/exports/index.dart';

class SignUpForm extends GetView<SignUpController> {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.signUpFormKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: controller.firstNameCtrl,
            isRequired: true,
            height: Sizes.HEIGHT_20,
            labelText: Strings.FIRST_NAME,
            labelColor: AppColors.black,
            prefixIcon: EneftyIcons.user_outline,
            prefixIconColor: AppColors.black,
            textColor: AppColors.black,
            cursorColor: AppColors.black,
            errorColor: AppColors.black,
            enableBorderColor: AppColors.black,
            focusBorderColor: AppColors.primary,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.name],
          ),
          const SpaceH4(),
          CustomTextFormField(
            controller: controller.lastNameCtrl,
            isRequired: true,
            height: Sizes.HEIGHT_20,
            labelText: Strings.LAST_NAME,
            labelColor: AppColors.black,
            prefixIcon: EneftyIcons.user_outline,
            prefixIconColor: AppColors.black,
            textColor: AppColors.black,
            cursorColor: AppColors.black,
            errorColor: AppColors.black,
            enableBorderColor: AppColors.black,
            focusBorderColor: AppColors.primary,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.name],
          ),
          const SpaceH4(),
          CustomTextFormField(
            controller: controller.emailCtrl,
            isRequired: true,
            height: Sizes.HEIGHT_20,
            labelText: Strings.EMAIL,
            labelColor: AppColors.black,
            prefixIcon: EneftyIcons.sms_outline,
            prefixIconColor: AppColors.black,
            textColor: AppColors.black,
            cursorColor: AppColors.black,
            errorColor: AppColors.black,
            enableBorderColor: AppColors.black,
            textCapitalization: TextCapitalization.none,
            focusBorderColor: AppColors.primary,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            validator: Validators.emailValidator.call,
          ),
          const SpaceH4(),
          Obx(
            () => CustomTextFormField(
              controller: controller.passwordCtrl,
              isRequired: true,
              height: Sizes.HEIGHT_20,
              obscureText: !controller.isPasswordVisible.value,
              labelText: Strings.PASSWORD,
              labelColor: AppColors.black,
              prefixIcon: EneftyIcons.lock_outline,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              errorColor: AppColors.black,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primary,
              suffixIconColor: AppColors.black,
              textCapitalization: TextCapitalization.none,
              suffixIcon: controller.isPasswordVisible.value
                  ? EneftyIcons.eye_slash_outline
                  : EneftyIcons.eye_outline,
              onSuffixTap: controller.togglePassword,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              keyboardType: TextInputType.text,
              inputFormatters: InputFormat.denySpace,
              onFieldSubmit: (s) {},
              validator: Validators.passLengthValidator.call,
            ),
          ),
          const SpaceH4(),
          Obx(
            () => CustomTextFormField(
              controller: controller.confirmPasswordCtrl,
              isRequired: true,
              height: Sizes.HEIGHT_20,
              obscureText: !controller.isConfirmPasswordVisible.value,
              labelText: Strings.CONFIRM_PASSWORD,
              labelColor: AppColors.black,
              prefixIcon: EneftyIcons.lock_outline,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              errorColor: AppColors.black,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primary,
              suffixIconColor: AppColors.black,
              textCapitalization: TextCapitalization.none,
              suffixIcon: controller.isConfirmPasswordVisible.value
                  ? EneftyIcons.eye_slash_outline
                  : EneftyIcons.eye_outline,
              onSuffixTap: controller.toggleConfirmPassword,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              keyboardType: TextInputType.text,
              inputFormatters: InputFormat.denySpace,
              onFieldSubmit: (s) {},
              validator: (value) {
                if ((value?.trim() ?? '').length < 8) {
                  return Validators.passLengthValidator.call(value);
                }
                if (!(Validators.passwordsMatch(
                    controller.passwordCtrl.text, (value ?? '')))) {
                  return Strings.PASSWORDS_DO_NOT_MATCH;
                }
                return null;
              },
            ),
          ),
          const SpaceH12(),
          IntlPhoneField(
            decoration: const InputDecoration(
              labelText: Strings.PHONE_NUMBER,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: AppColors.black),
              ),
            ),
            autovalidateMode: AutovalidateMode.disabled,
            controller: controller.phoneCtrl,
            keyboardType: TextInputType.number,
            initialCountryCode: 'PK',
            languageCode: "en",
            onChanged: (phone) {},
            onCountryChanged: (country) => controller.country = country,
            inputFormatters: InputFormat.onlyNumber,
          ),
          const SpaceH30(),
          CustomButton.solid(
            backgroundColor: AppColors.primary,
            textColor: AppColors.white,
            text: Strings.SIGNUP,
            onTapAsync: () async => controller.onSignUp(),
            radius: Sizes.RADIUS_12,
            constraints: const BoxConstraints(minHeight: 55),
          ),
          const SpaceH30(),
          GestureDetector(
            onTap: () => Get.offNamed(Routes.LOGIN),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Strings.ALREADY_HAVE_AN_ACCOUNT,
                  style: context.titleMedium.copyWith(color: AppColors.black),
                ),
                const SpaceW10(),
                Text(
                  Strings.LOGIN,
                  style: context.titleLarge.copyWith(
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SpaceH16(),
        ],
      ),
    );
  }
}
