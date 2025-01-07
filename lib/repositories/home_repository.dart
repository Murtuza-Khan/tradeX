import 'package:tradex/dummy/received_points_data.dart';
import '../resources/exports/index.dart';

class HomeRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<ReceivedPointsModel> getReceivedPoints() async {
    final response = await apiService.getApi(
      Urls.AWARD_HISTORY,
      queryParameters: {
        "accountId": AuthManager.instance.company.id,
        "page": 1,
        "limit": 10,
      },
    );
    if (response is bool) return ReceivedPointsModel();
    return ReceivedPointsModel.fromMap(response);
  }
}
