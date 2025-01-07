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
            CustomTextFormField(
              controller: controller.cnicCtrl,
              fillColor: AppColors.white,
              textCapitalization: TextCapitalization.none,
              isRequired: true,
              height: Sizes.HEIGHT_20,
              labelText: Strings.CNIC,
              labelColor: AppColors.black,
              prefixIcon: EneftyIcons.card_outline,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primary,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              inputFormatters: [
                ...InputFormat.cnicCount,
                CnicInputFormatter(),
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
