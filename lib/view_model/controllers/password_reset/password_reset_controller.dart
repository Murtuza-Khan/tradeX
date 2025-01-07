import '../../../resources/exports/index.dart';

class PasswordResetController extends GetxController {
  late GlobalKey<FormState> formKey;
  late TextEditingController newPasswordCtrl;
  late TextEditingController confirmPasswordCtrl;

  late String token;

  RxBool isNewPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  void toggleNewPassword() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPassword() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> onConfirm() async {
    if (formKey.currentState?.validate() ?? false) {
      ApiResult result = await ResetPasswordRepository.resetPassword(
        token: token,
        data: {
          "password": newPasswordCtrl.text,
          "password_confirmation": confirmPasswordCtrl.text,
        },
      );
      if (result == ApiResult.success) {
        CustomSnackBar.successSnackBar(
          message: Strings.PASSWORD_RESET_SUCCESSFULLY,
        );
        Get.offAllNamed(Routes.LANDING);
      }
    }
  }

  @override
  void onInit() {
    token = Get.arguments != null ? Get.arguments['token'] : '';
    formKey = GlobalKey<FormState>();
    newPasswordCtrl = TextEditingController();
    confirmPasswordCtrl = TextEditingController();
    super.onInit();
  }
}
