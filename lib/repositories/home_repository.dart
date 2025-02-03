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
    ReceivedPointsModel data = ReceivedPointsModel.fromMap(response);
    Map<String, dynamic> modifiedResponse = data.toMap();
    modifiedResponse['app_colors'] = {
      "primary_color": "#c66f16",
      // "primary_color": "#3dc411",
      "secondary_color": "#000000",
      "tertiary_color": "#FFFFFF",
      "background_color": "#F4F7FE"
    };
    MacLog.printG("THEME CHANGED ..........$modifiedResponse");

    ReceivedPointsModel data2 = ReceivedPointsModel.fromMap(modifiedResponse);

    if (AuthManager.instance.appColorsModel
        .isThemeChanged(data2.appColors ?? AppColorsModel())) {
      AppColors.initializeAppColors(data2.appColors ?? AppColorsModel());
      AdaptiveTheme.of(Get.context!).setTheme(
        light: ThemeController().getTheme,
      );
      await AuthManager.instance.saveAndUpdateSession(
        appColors: data2.appColors,
      );
    } else {
      MacLog.printR("THEME NOT CHANGED ..........");
    }
    return data2;
  }
}
