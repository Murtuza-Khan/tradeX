import '../resources/exports/index.dart';

class SwitchAccountRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<ApiResult> switchAccount(int id) async {
    // final response = await apiService.postApi(
    //   Urls.LOGIN,
    //   body: {"company_id": id},
    // );
    // if (response is bool) return ApiResult.fail;
    // CompaniesModel company = CompaniesModel.fromMap(response);
    CompaniesModel company = SwitchAccountHelper.company.copyWith(
      isSelected: true,
      isPhoneVerified: true,
    );
    AuthManager.instance.saveAndUpdateSession(company: company);
    return ApiResult.success;
  }
}
