import '../../../resources/exports/index.dart';

class LoginController extends GetxController {
  late GlobalKey<FormState> loginFormKey;
  late TextEditingController emailCtrl;
  late TextEditingController passCtrl;

  RxBool isPasswordVisible = false.obs;

  void toggleRememberCredentials(bool? value) =>
      AuthManager.instance.rememberCredentials.value = value!;

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    if (loginFormKey.currentState?.validate() ?? false) {}
  }

  @override
  void onInit() {
    loginFormKey = GlobalKey<FormState>();
    emailCtrl = TextEditingController();
    passCtrl = TextEditingController();
    super.onInit();
  }
}
