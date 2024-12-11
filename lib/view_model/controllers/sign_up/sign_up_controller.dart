import '../../../resources/exports/index.dart';

class SignUpController extends GetxController {
  late GlobalKey<FormState> signUpFormKey;
  late TextEditingController firstNameCtrl;
  late TextEditingController lastNameCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController passwordCtrl;
  late TextEditingController confirmPasswordCtrl;

  Country? country;

  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPassword() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> onSignUp() async {
    SendOtpOn sendOtpOn = SendOtpOn.email;
    if (signUpFormKey.currentState?.validate() ?? false) {
      log.e(sendOtpOn);
    }
  }

  @override
  void onInit() {
    signUpFormKey = GlobalKey<FormState>();
    firstNameCtrl = TextEditingController();
    lastNameCtrl = TextEditingController();
    phoneCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    confirmPasswordCtrl = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}
