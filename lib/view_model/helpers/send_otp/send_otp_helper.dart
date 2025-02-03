import '../../../resources/exports/index.dart';

class SendOtpHelper {
  static String phone = '';
  static String? switchAccountPhone;

  static Future<void> sendOtp(String mobile) async {
    if (mobile.isEmpty) {
      return CustomSnackBar.errorSnackBar(message: Strings.PHONE_REQUIRED);
    }
    (ApiResult, int?) otp = await AuthRepository.sendOtp(mobile: mobile);
    if (otp.$1 == ApiResult.success) {
      MacLog.printG("$mobile\n${otp.$2}");
      CustomSnackBar.successSnackBar(
        message: "${kDebugMode ? "${otp.$2} " : ""}${Strings.PLEASE_VERIFY}",
      );
      if (Get.currentRoute != Routes.OTP) {
        Get.toNamed(Routes.OTP);
      }
    }
  }
}
