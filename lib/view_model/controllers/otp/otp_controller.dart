import '../../../resources/exports/index.dart';

class OtpController extends GetxController {
  Timer? otpTimer;
  Duration myDuration = const Duration(minutes: 2);
  bool isLoading = false;

  late TextEditingController pinCtrl;

  Future<void> resendOtp() async {
    isLoading = true;
    update(['confirm_otp_button']);
    UserModel? user = AuthManager.instance.session.value?.user;
    Map<String, dynamic> otpData = {
      "phone": "${user?.countrycode ?? '92'}${user?.phone ?? ""}"
    };
    log.w(otpData);
    // implement api function here
    myDuration = const Duration(minutes: 2);
    startTimer();
    isLoading = false;
    update(['confirm_otp_button']);
  }

  Future<void> verfyOtp() async {}

  void startTimer() {
    update(["resend_otp"]);
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
