import '../../../resources/exports/index.dart';

class LoginController extends GetxController {
  late GlobalKey<FormState> loginFormKey;
  late TextEditingController phoneCtrl;
  late TextEditingController passCtrl;

  Country? country;
  RxBool isPasswordVisible = false.obs;

  void toggleRememberCredentials(bool? value) =>
      AuthManager.instance.rememberCredentials.value = value!;

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    // if (loginFormKey.currentState?.validate() ?? false) {
    CustomSnackBar.successSnackBar(message: Strings.PLEASE_VERIFY);
    Get.toNamed(Routes.OTP);
    // }
  }

  @override
  void onInit() {
    loginFormKey = GlobalKey<FormState>();
    phoneCtrl = TextEditingController();
    passCtrl = TextEditingController();
    super.onInit();
  }
}
