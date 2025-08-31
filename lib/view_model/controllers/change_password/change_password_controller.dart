import '../../../resources/exports/index.dart';

class ChangePasswordController extends GetxController {
  late GlobalKey<FormState> formKey;
  late TextEditingController oldPassCtrl;
  late TextEditingController newPassCtrl;
  late TextEditingController confirmPassCtrl;

  RxBool isOldPasswordVisible = false.obs;
  RxBool isNewPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  void toggleOldPassword() {
    isOldPasswordVisible.value = !isOldPasswordVisible.value;
  }

  void toggleNewPassword() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPassword() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> changePassword() async {
    if (formKey.currentState?.validate() ?? false) {
      ApiResult result = await ChangePasswordRepository.changePassword(
        data: {
          "old_password": oldPassCtrl.text,
          "new_password": newPassCtrl.text,
          "new_password_confirmation": confirmPassCtrl.text,
        },
      );
      if (result == ApiResult.success) {
        Get.back();
        CustomSnackBar.successSnackBar(
          message: Strings.PASSWORD_CHANGED,
        );
      }
    }
  }

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    oldPassCtrl = TextEditingController();
    newPassCtrl = TextEditingController();
    confirmPassCtrl = TextEditingController();
    super.onInit();
  }
}
