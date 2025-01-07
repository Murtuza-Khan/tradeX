import '../../../resources/exports/index.dart';

class OtpController extends GetxController {
  Timer? otpTimer;
  Duration myDuration = const Duration(minutes: 2);
  bool isLoading = false;

  late TextEditingController pinCtrl;

  Future<void> resendOtp() async {
    isLoading = true;
    pinCtrl.clear();
    update(['confirm_otp_button']);
    await SendOtpHelper.sendOtp(
      SendOtpHelper.switchAccountPhone ??
          AuthManager.instance.company.phone ??
          SendOtpHelper.phone,
    );
    myDuration = const Duration(minutes: 2);
    startTimer();
    isLoading = false;
    update(['confirm_otp_button']);
  }

  Future<void> verfyOtp() async {
    (ApiResult, String) result = await OtpRepository.verifyOtp(
      data: {
        "otp": pinCtrl.text,
        "mobile": SendOtpHelper.switchAccountPhone ??
            AuthManager.instance.company.phone ??
            SendOtpHelper.phone,
      },
    );
    if (result.$1 == ApiResult.fail) return;
    if (Get.previousRoute == Routes.LOGIN) {
      CompaniesModel company = AuthManager.instance.company.copyWith(
        isPhoneVerified: true,
      );
      await AuthManager.instance.saveAndUpdateSession(company: company);
      CustomSnackBar.successSnackBar(message: Strings.LOGGED_IN_SUCCESSFULLY);
      Get.offAllNamed(Routes.LANDING);
    } else if (Get.previousRoute == Routes.SWITCH_ACCOUNT) {
      ApiResult result = await SwitchAccountRepository.switchAccount(
        SwitchAccountHelper.company.id ?? -1,
      );
      if (result == ApiResult.fail) return;
      CustomSnackBar.successSnackBar(message: Strings.ACCOUNT_SWITCHED);
      SwitchAccountHelper.company = CompaniesModel();
      SendOtpHelper.switchAccountPhone = null;
      Get.find<HomeController>().update(['refresh_home_data']);
      Get.close(2);
    } else {
      CustomSnackBar.successSnackBar(message: Strings.OTP_VERIFIED);
      Get.offNamed(Routes.PASSWORD_RESET, arguments: {"token": result.$2});
    }
  }

  void startTimer() {
    otpTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        final seconds = myDuration.inSeconds - 1;
        if (seconds == -1) {
          otpTimer?.cancel();
          update(["confirm_otp_button"]);
        } else {
          myDuration = Duration(seconds: seconds);
        }
        update(["otp_timer_text"]);
      },
    );
  }

  String getOtpDuration() {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void onInit() {
    pinCtrl = TextEditingController();
    startTimer();
    super.onInit();
  }

  @override
  void dispose() {
    pinCtrl.dispose();
    otpTimer?.cancel();
    super.dispose();
  }
}
