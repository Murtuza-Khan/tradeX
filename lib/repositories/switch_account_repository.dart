import '../resources/exports/index.dart';

class SwitchAccountRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<List<CompaniesModel>> getCompanies() async {
    final response = await apiService.getApi(Urls.ACCOUNTS);
    if (response is bool) return [];
    return CompaniesModel.listFromJson(response);
  }

  static Future<ApiResult> switchAccount(int id) async {
    final response = await apiService.putApi(
      Urls.SELECT_ACCOUNT,
      body: {"account_id": id},
    );
    if (response is bool) return ApiResult.fail;
    CompaniesModel company = CompaniesModel.fromMap(response);
    AuthManager.instance.saveAndUpdateSession(company: company);
    return ApiResult.success;
  }
}
