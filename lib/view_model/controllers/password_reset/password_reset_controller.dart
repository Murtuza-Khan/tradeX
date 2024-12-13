import '../../../resources/exports/index.dart';

class PasswordResetController extends GetxController {
  late GlobalKey<FormState> formKey;
  late TextEditingController newPasswordCtrl;
  late TextEditingController confirmPasswordCtrl;

  RxBool isNewPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  void toggleNewPassword() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPassword() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void onConfirm() {
    // if(formKey.currentState?.validate() ?? false){
    CustomSnackBar.successSnackBar(message: Strings.PASSWORD_RESET_SUCCESSFULLY);
    Get.close(2);

    // }
  }

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    newPasswordCtrl = TextEditingController();
    confirmPasswordCtrl = TextEditingController();
    super.onInit();
  }
}
