import '../../resources/exports/index.dart';

class ForgotPassword extends GetView<ForgotPasswordController> {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.FORGOT_PASSWORD),
      body: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.FORGOT_PASSWORD,
              style: context.headlineMedium.copyWith(color: AppColors.primary),
            ),
            Text(Strings.PLEASE_ENTER_PHONE, style: context.bodyLarge),
            SpaceH20(),
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
            SpaceH16(),
            CustomButton.solid(
              backgroundColor: AppColors.primary,
              textColor: AppColors.white,
              text: Strings.CONTINUE,
              onTapAsync: () async => controller.onContinue(),
              radius: Sizes.RADIUS_12,
              constraints: const BoxConstraints(minHeight: 55),
            ),
          ],
        ).paddingAll(16.0),
      ),
    );
  }
}
