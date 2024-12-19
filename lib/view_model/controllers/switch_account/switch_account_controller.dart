import '../../../resources/exports/index.dart';

class SwitchAccountController extends GetxController {
  List<CompaniesModel> companies = [];

  void onSwitchCompany(int index) {
    if (companies[index].isSelected ?? false) return;
    int selectedIndex = companies.indexWhere(
      (e) => (e.isSelected ?? false) == true,
    );
    if (selectedIndex != -1) {
      companies[selectedIndex].isSelected = false;
      companies[index].isSelected = true;
    }
    update(['toggle_company_account']);
  }

  void onSave() {
    int selectedIndex = companies.indexWhere(
      (e) => (e.isSelected ?? false) == true,
    );
    if (selectedIndex == -1) return;
    if (companies[selectedIndex].isPhoneVerified ?? false) {
      AuthManager.instance.saveAndUpdateSession(
        company: companies[selectedIndex],
      );
      CustomSnackBar.successSnackBar(message: Strings.ACCOUNT_SWITCHED);
      Get.back();
    } else {
      SwitchAccountHelper.company = companies[selectedIndex];
      Get.toNamed(Routes.OTP);
    }
  }
}
