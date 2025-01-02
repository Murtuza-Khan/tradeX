import 'package:tradex/dummy/login_data.dart';

import '../resources/exports/index.dart';

class AuthRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<ApiResult> login({
    required String mobile,
    required String password,
  }) async {
    // final response = await apiService.postApi(
    //   Urls.LOGIN,
    //   returnResponse: true,
    //   body: {"mobile": mobile, "password": password},
    // );

    // if (!(response as ApiResponse).status) {
    //   Map<String, dynamic> errorData = response.successContents ?? {};
    //   if (errorData.isEmpty) {
    //     CustomSnackBar.errorSnackBar(
    //       message: response.message ?? Strings.SOMETHING_WENT_WRONG,
    //     );
    //   } else {
    //     CustomSnackBar.errorSnackBar(message: errorData.entries.first.value);
    //   }
    //   return ApiResult.fail;
    // }
    Session session = Session.fromJson(loginData);
    await AuthManager.instance.login(session);
    return ApiResult.success;
  }
}