import '../resources/exports/index.dart';

class ProfileRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<UserModel?> updateProfile({
    required Map<String, dynamic> data,
    XFile? profileImage,
  }) async {
    final response = await apiService.multiPartApi(
      Urls.UPDATE_PROFILE,
      files: {
        if (profileImage != null) "profile_image": [profileImage],
      },
      data: data,
    );
    if (response is bool) return null;
    return UserModel.fromJson(response);
  }
}
