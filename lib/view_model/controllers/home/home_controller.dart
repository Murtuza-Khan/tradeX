import '../../../resources/exports/index.dart';

class HomeController extends GetxController {
  List<CompaniesModel> companies = [];
  bool refreshBanners = false;

  CompaniesModel get selectedCompany => AuthManager.instance.company.id == null
      ? companies[0]
      : AuthManager.instance.company;

  @override
  void onInit() {
    refreshBanners = true;
    super.onInit();
  }
}
