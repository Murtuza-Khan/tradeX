import '../../resources/exports/index.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: '', onTap: Get.back),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            bottom: Sizes.PADDING_40,
            left: Sizes.PADDING_16,
            right: Sizes.PADDING_16,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.ENTER_OTP.tr,
                    style: context.headlineLarge.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SpaceH4(),
                  Text(
                    Strings.ONE_TIME_PASS.tr,
                    style: context.titleMedium.copyWith(
                      color: AppColors.greyShade2,
                    ),
                  ),
                  const SpaceH32(),
                  Center(child: _buildPinField()),
                  const SpaceH20(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GetBuilder<OtpController>(
                        id: "otp_timer_text",
                        builder: (_) {
                          return Text(
                            controller.getOtpDuration(),
                            style: context.titleMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          );
                        },
                      ),
                      GetBuilder<OtpController>(
                        id: "confirm_otp_button",
                        builder: (_) {
                          return controller.isLoading
                              ? CustomLoading.spinKitThreeBouncePrimary
                              : GestureDetector(
                                  onTap: controller.resendOtp,
                                  child: Text(
                                    controller.otpTimer == null ||
                                            controller.otpTimer!.isActive
                                        ? ""
                                        : Strings.RESEND.tr,
                                    style: context.titleMedium.copyWith(
                                      color: AppColors.error,
                                    ),
                                  ),
                                );
                        },
                      ),
                    ],
                  ),
                  const SpaceH20(),
                  CustomButton.solid(
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.white,
                    text: Strings.CONTINUE,
                    onTapAsync: () => controller.verfyOtp(),
                    radius: 6,
                    constraints: const BoxConstraints(minHeight: 55),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinField() {
    const focusedBorderColor = AppColors.primary;
    final fillColor = AppColors.primaryLight.withOpacity(0.25);
    const borderColor = AppColors.primary;

    final defaultPinTheme = PinTheme(
      width: 70,
      height: 70,
      textStyle: const TextStyle(fontSize: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
    );
    return Pinput(
      length: 6,
      obscureText: true,
      obscuringWidget: Container(
        width: 20.0,
        height: 20.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),
      ),
      controller: controller.pinCtrl,
      defaultPinTheme: defaultPinTheme,
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onCompleted: (pin) {
        debugPrint('onCompleted: $pin');
      },
      onChanged: (value) {
        debugPrint('onChanged: $value');
      },
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 9),
            width: 22,
            height: 1,
            color: focusedBorderColor,
          ),
        ],
      ),
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: focusedBorderColor, width: 2),
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          color: fillColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: focusedBorderColor),
        ),
      ),
      errorPinTheme: defaultPinTheme.copyBorderWith(
        border: Border.all(color: AppColors.error),
      ),
    );
  }
}
