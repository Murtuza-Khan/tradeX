import '../../../resources/exports/index.dart';

class LoginController extends GetxController {
  late GlobalKey<FormState> loginFormKey;
  late TextEditingController cnicCtrl;
  late TextEditingController passCtrl;

  Country? country;
  RxBool isPasswordVisible = false.obs;

  void toggleRememberCredentials(bool? value) =>
      AuthManager.instance.rememberCredentials.value = value!;

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    await AuthRepository.login(mobile: cnicCtrl.text, password: passCtrl.text);
    // if (loginFormKey.currentState?.validate() ?? false) {
    if (AuthManager.instance.company.isPhoneVerified ?? false) {
      Get.offAllNamed(Routes.LANDING);
    } else {
      CustomSnackBar.successSnackBar(message: Strings.PLEASE_VERIFY);
      Get.toNamed(Routes.OTP);
    }
    // }
  }

  @override
  void onInit() {
    loginFormKey = GlobalKey<FormState>();
    cnicCtrl = TextEditingController();
    passCtrl = TextEditingController();
    super.onInit();
  }
}
