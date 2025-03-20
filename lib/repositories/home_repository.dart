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
    ReceivedPointsModel result = ReceivedPointsModel.fromMap(response);
    if (AuthManager.instance.appColorsModel
        .isThemeChanged(result.appColors ?? AppColorsModel())) {
      AppColors.initializeAppColors(result.appColors ?? AppColorsModel());
      AdaptiveTheme.of(Get.context!).setTheme(
        light: ThemeController().getTheme,
      );
      await AuthManager.instance.saveAndUpdateSession(
        appColors: result.appColors,
      );
      await Future.delayed(Durations.medium2);
    } else {
      MacLog.printR("THEME NOT CHANGED ..........");
    }
    return result;
  }
}
