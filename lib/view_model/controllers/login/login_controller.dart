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
    if (loginFormKey.currentState?.validate() ?? false) {
      ApiResult result = await AuthRepository.login(
        cnic: cnicCtrl.text.replaceAll("-", ""),
        password: passCtrl.text,
      );
      if (result == ApiResult.success) {
        if (AuthManager.instance.company.isPhoneVerified ?? false) {
          Get.offAllNamed(Routes.LANDING);
        } else {
          await SendOtpHelper.sendOtp(AuthManager.instance.company.phone ?? "");
        }
      }
    }
  }

  @override
  void onInit() {
    loginFormKey = GlobalKey<FormState>();
    cnicCtrl = TextEditingController();
    passCtrl = TextEditingController();
    super.onInit();
  }
}
