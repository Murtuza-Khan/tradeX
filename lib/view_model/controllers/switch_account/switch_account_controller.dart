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
    AuthManager.instance.saveAndUpdateSession(company: companies[index]);
    update(['toggle_company_account']);
  }

  void onSave() {
    if ((AuthManager.instance.company.isPhoneVerified ?? false) == false) {
      Get.toNamed(Routes.OTP);
    }
  }
}
