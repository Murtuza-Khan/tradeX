import '../../../resources/exports/index.dart';

class ProfileController extends GetxController {
  late GlobalKey<FormState> formKey;
  late TextEditingController firstNameCtrl;
  late TextEditingController lastNameCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController emailCtrl;

  Country? country;

  void onGetProfile() {
    UserModel user = AuthManager.instance.user;
    CompaniesModel company = AuthManager.instance.company;

    firstNameCtrl.text = user.firstName?.capitalizeFirstLetter ?? "";
    lastNameCtrl.text = user.lastName?.capitalizeFirstLetter ?? "";
    phoneCtrl.text = company.phone ?? "";
    emailCtrl.text = user.email ?? "";
  }

  Future<void> updateProfile() async {
    ApiResult result = await ProfileRepository.updateProfile(
      data: {
        "first_name": firstNameCtrl.text,
        "last_name": lastNameCtrl.text,
        "email": emailCtrl.text,
      },
    );
    if (result == ApiResult.success) {
      UserModel user = AuthManager.instance.user.copyWith(
        firstName: firstNameCtrl.text,
        lastName: lastNameCtrl.text,
        email: emailCtrl.text,
      );
      await AuthManager.instance.saveAndUpdateSession(user: user);
      Get.back();
      CustomSnackBar.successSnackBar(message: Strings.PROFILE_UPDATE);
    }
  }

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    firstNameCtrl = TextEditingController();
    lastNameCtrl = TextEditingController();
    phoneCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    onGetProfile();
    super.onInit();
  }
}
