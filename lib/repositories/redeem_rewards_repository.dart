import '../resources/exports/index.dart';

class RedeemRewardsRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<RedeemHistory?> redeemPoints({
    required Map<String, dynamic> data,
  }) async {
    final response = await apiService.postApi(
      Urls.REDEEM,
      body: data,
      returnResponse: true,
    );
    if (!(response as ApiResponse).status) {
      Map<String, dynamic> errorData = response.successContents ?? {};
      if (errorData.isEmpty) {
        CustomSnackBar.errorSnackBar(
          message: response.message ?? Strings.SOMETHING_WENT_WRONG,
        );
      } else {
        CustomSnackBar.errorSnackBar(message: errorData.entries.first.value);
      }
      return null;
    }
    return RedeemHistory.fromMap(response.successContents);
  }
}
