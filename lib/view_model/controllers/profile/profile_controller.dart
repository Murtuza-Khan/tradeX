import '../../../resources/exports/index.dart';

class ProfileController extends GetxController {
  late GlobalKey<FormState> formKey;
  late TextEditingController firstNameCtrl;
  late TextEditingController lastNameCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController emailCtrl;

  Country? country;
  RxBool isUpdateProfileBtnEnabled = false.obs;

  void onGetProfile() {
    UserModel user = AuthManager.instance.user;
    CompaniesModel company = AuthManager.instance.company;

    firstNameCtrl.text = user.firstName?.capitalizeFirstLetter ?? "";
    lastNameCtrl.text = user.lastName?.capitalizeFirstLetter ?? "";
    phoneCtrl.text = company.phone ?? "";
    if (phoneCtrl.text.isNotEmpty &&
        phoneCtrl.text.startsWith("0") &&
        phoneCtrl.text.length >= 11) {
      phoneCtrl.text = phoneCtrl.text.substring(1);
    }
    emailCtrl.text = user.email ?? "";
  }

  void toggleUpdateProfileBtnEnaled() {
      MacLog.printG("IN HERE.........");

    if (firstNameCtrl.text.trim() == AuthManager.instance.user.firstName &&
        lastNameCtrl.text.trim() == AuthManager.instance.user.lastName &&
        emailCtrl.text.trim() == AuthManager.instance.user.email) {
      isUpdateProfileBtnEnabled.value = false;
      MacLog.printG("IN HERE.........");
    } else {
      isUpdateProfileBtnEnabled.value = true;
      MacLog.printR("IN HERE 2.........");
    }
  }

  Future<void> updateProfile() async {
    if (formKey.currentState?.validate() ?? false) {
      ApiResult result = await ProfileRepository.updateProfile(
        data: {
          "first_name": firstNameCtrl.text.trim(),
          "last_name": lastNameCtrl.text.trim(),
          "email": emailCtrl.text,
        },
      );
      if (result == ApiResult.success) {
        UserModel user = AuthManager.instance.user.copyWith(
          firstName: firstNameCtrl.text.trim(),
          lastName: lastNameCtrl.text.trim(),
          email: emailCtrl.text,
        );
        await AuthManager.instance.saveAndUpdateSession(user: user);
        Get.find<UserDashboardController>().update(['user_dash_welcome_card']);
        Get.back();
        CustomSnackBar.successSnackBar(message: Strings.PROFILE_UPDATE);
      }
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
