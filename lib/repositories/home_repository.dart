import 'package:tradex/dummy/companies_data.dart';
import '../resources/exports/index.dart';

class HomeRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<List<CompaniesModel>> getCompanies() async {
    return Future.delayed(Durations.medium2, (){
      return CompaniesModel.listFromJson(companiesData);
    });
  }
}
