import '../../../resources/exports/index.dart';

class ProfileController extends GetxController {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController emailCtrl;

  ProfileModel profile = ProfileModel();
  Country? country;

  void onGetProfile() {
    nameCtrl.text =
        "${(profile.firstName?.capitalizeFirstLetter ?? "")} ${(profile.lastName?.capitalizeFirstLetter ?? "")}";
    phoneCtrl.text = profile.phone ?? "";
    emailCtrl.text = profile.email ?? "";
  }

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    nameCtrl = TextEditingController();
    phoneCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    super.onInit();
  }
}
