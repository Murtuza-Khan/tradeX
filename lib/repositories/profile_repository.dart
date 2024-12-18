import 'package:tradex/dummy/profile_data.dart';
import '../resources/exports/index.dart';

class ProfileRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<ProfileModel> getUserProfile() async {
    return Future.delayed(Durations.medium2, () {
      return ProfileModel.fromMap(profileData);
    });
  }
}
