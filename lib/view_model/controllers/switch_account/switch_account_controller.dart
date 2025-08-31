import '../../../resources/exports/index.dart';

class SwitchAccountController extends GetxController {
  List<CompaniesModel> companies = [];

  void onSwitchCompany(int index) {
    if (companies[index].isSelected ?? false) return;
    int selectedIndex = companies.indexWhere((e) => e.isSelected ?? false);
    if (selectedIndex != -1) {
      companies[selectedIndex].isSelected = false;
    }
    companies[index].isSelected = true;
    update(['toggle_company_account']);
  }

  Future<void> onSave() async {
    int selectedIndex = companies.indexWhere(
      (e) => (e.isSelected ?? false) == true,
    );
    if (selectedIndex == -1) return;
    if (companies[selectedIndex].isPhoneVerified ?? false) {
      ApiResult result = await SwitchAccountRepository.switchAccount(
        companies[selectedIndex].id ?? -1,
      );
      if (result == ApiResult.success) {
        CustomSnackBar.successSnackBar(message: Strings.ACCOUNT_SWITCHED);
        if (LandingController.instance.selectedIndex == 0) {
          Get.find<HomeController>().update(['refresh_home_data']);
        } else {
          LandingController.instance.onNavigate(0, Routes.HOME);
        }
        Get.back();
      }
    } else {
      SwitchAccountHelper.company = companies[selectedIndex];
      SendOtpHelper.switchAccountPhone = companies[selectedIndex].phone;
      await SendOtpHelper.sendOtp(companies[selectedIndex].phone ?? "");
    }
  }
}
