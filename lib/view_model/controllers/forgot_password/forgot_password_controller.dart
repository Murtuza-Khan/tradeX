import '../../../resources/exports/index.dart';

class ForgotPasswordController extends GetxController {
  late GlobalKey<FormState> formKey;
  late TextEditingController phoneCtrl;

  Country? country;

  Future<void> onContinue() async {
    // if (formKey.currentState?.validate() ?? false) {
      // (ApiResult, String) result = await AuthRepository.forgetPassword(
      //   email: phoneCtrl.text,
      // );
      // if (result.$2.isNotEmpty) {
      //   CustomSnackBar.successSnackBar(message: result.$2);
      //   Get.back();
      // }
    // }

    Get.toNamed(Routes.OTP);
  }

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    phoneCtrl = TextEditingController();
    super.onInit();
  }
}
