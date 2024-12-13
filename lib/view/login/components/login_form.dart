import '../../../resources/exports/index.dart';

class LoginForm extends GetView<LoginController> {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          Stack(
            children: [
              IntlPhoneField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                  labelText: Strings.PHONE_NUMBER,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: AppColors.secondary),
                  ),
                ),
                autovalidateMode: AutovalidateMode.disabled,
                controller: controller.phoneCtrl,
                keyboardType: TextInputType.number,
                initialCountryCode: 'PK',
                languageCode: "en",
                onChanged: (phone) {
                  controller.update(['update_save_profile_btn']);
                },
                onCountryChanged: (country) => controller.country = country,
                inputFormatters: InputFormat.onlyNumber,
              ),
              Container(
                width: 95,
                height: 57,
                color: Colors.transparent,
              ),
            ],
          ),
          const SpaceH10(),
          Obx(
            () => CustomTextFormField(
              controller: controller.passCtrl,
              isRequired: true,
              textCapitalization: TextCapitalization.none,
              height: Sizes.HEIGHT_20,
              obscureText: !controller.isPasswordVisible.value,
              labelText: Strings.PASSWORD,
              labelColor: AppColors.black,
              prefixIcon: EneftyIcons.lock_outline,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primary,
              suffixIconColor: AppColors.black,
              suffixIcon: controller.isPasswordVisible.value
                  ? EneftyIcons.eye_slash_outline
                  : EneftyIcons.eye_outline,
              onSuffixTap: controller.togglePassword,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              keyboardType: TextInputType.text,
              inputFormatters: InputFormat.denySpace,
              onFieldSubmit: (s) {},
            ),
          ),
          const SpaceH8(),
          _buildRememberMe(context),
          const SpaceH8(),
          CustomButton.solid(
            backgroundColor: AppColors.primary,
            textColor: AppColors.white,
            text: Strings.LOGIN,
            onTapAsync: () async => controller.login(),
            radius: Sizes.RADIUS_12,
            constraints: const BoxConstraints(minHeight: 55),
          ),
          const SpaceH16(),
        ],
      ),
    );
  }

  Row _buildRememberMe(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  checkColor: Colors.white,
                  side: const BorderSide(color: Colors.black),
                  visualDensity: const VisualDensity(horizontal: -4),
                  activeColor: AppColors.primary,
                  value: AuthManager.instance.rememberCredentials.value,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.RADIUS_2),
                  ),
                  onChanged: controller.toggleRememberCredentials,
                ),
              ),
              const SpaceW8(),
              Text(
                Strings.REMEMBER_ME.tr,
                style: context.bodyLarge.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: Text(
            Strings.FORGOT_PASSWORD.tr,
            style: context.bodyLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
