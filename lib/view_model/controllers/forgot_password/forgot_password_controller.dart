import '../../../resources/exports/index.dart';

class ForgotPasswordController extends GetxController {
  late GlobalKey<FormState> formKey;
  late TextEditingController cnicCtrl;

  Country? country;
  List<UserMobileNumbers> numbers = [];

  Future<void> onContinue() async {
    if (formKey.currentState?.validate() ?? false) {
      numbers = await AuthRepository.forgetPassword(
        cnic: cnicCtrl.text.replaceAll("-", ""),
      );
      if (numbers.isNotEmpty) {
        await CustomDialog.showFullScreenDialog(content: NumbersList());
      }
    }
  }

  Future<void> onSendOtp() async {
    int index = numbers.indexWhere((e) => e.isSelected);
    if (index == -1) {
      return CustomSnackBar.errorSnackBar(message: Strings.SELECT_A_PHONE);
    } else {
      SendOtpHelper.phone = numbers[index].mobile ?? "";
      await SendOtpHelper.sendOtp(numbers[index].mobile ?? "");
    }
  }

  void onSwitchPhoneNumber(int index) {
    if (numbers[index].isSelected) return;
    int selectedIndex = numbers.indexWhere((e) => e.isSelected == true);
    if (selectedIndex != -1) {
      numbers[selectedIndex].isSelected = false;
    }
    numbers[index].isSelected = true;
    update(['toggle_user_phone']);
  }

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    cnicCtrl = TextEditingController();
    super.onInit();
  }
}
