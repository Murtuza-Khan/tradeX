import '../../../resources/exports/index.dart';

class ProfileController extends GetxController {
  late GlobalKey<FormState> formKey;
  late TextEditingController firstNameCtrl;
  late TextEditingController lastNameCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController emailCtrl;
  late String profileImage;
  late FocusScopeNode focusScopeNode;

  Country? country;
  RxBool isUpdateProfileBtnEnabled = false.obs;

  XFile? file;
  Uint8List? imageBytes;

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
    profileImage = user.profileImage ?? "";
  }

  void toggleUpdateProfileBtnEnaled() {
    if (firstNameCtrl.text.trim() == AuthManager.instance.user.firstName &&
        lastNameCtrl.text.trim() == AuthManager.instance.user.lastName &&
        emailCtrl.text.trim() == AuthManager.instance.user.email &&
        file == null) {
      isUpdateProfileBtnEnabled.value = false;
    } else {
      isUpdateProfileBtnEnabled.value = true;
    }
  }

  void pickFile(BuildContext context) async {
    try {
      XFile? tempFile = await ImagePickerService.showImagePickerSheet(context);
      if (tempFile != null) {
        file = tempFile;
        toggleUpdateProfileBtnEnaled.call();
        imageBytes = await file?.readAsBytes();
      }
      update(['profile_image', 'update_save_profile_btn']);
    } catch (e) {
      MacLog.printR(e);
    }
  }

  Future<void> updateProfile() async {
    if (formKey.currentState?.validate() ?? false) {
      UserModel? result = await ProfileRepository.updateProfile(
        profileImage: file,
        data: {
          "first_name": firstNameCtrl.text.trim(),
          "last_name": lastNameCtrl.text.trim(),
          "email": emailCtrl.text,
        },
      );
      if (result != null) {
        focusScopeNode.unfocus();
        UserModel user = AuthManager.instance.user.copyWith(
          firstName: result.firstName,
          lastName: result.lastName,
          email: result.email,
          profileImage: result.profileImage,
        );
        await AuthManager.instance.saveAndUpdateSession(user: user);
        Get.find<UserDashboardController>().update(['user_dash_welcome_card']);
        file = null;
        onGetProfile();
        toggleUpdateProfileBtnEnaled.call();
        CustomSnackBar.successSnackBar(message: Strings.PROFILE_UPDATE);
      }
    }
  }

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    focusScopeNode = FocusScopeNode();
    firstNameCtrl = TextEditingController();
    lastNameCtrl = TextEditingController();
    phoneCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    onGetProfile();
    super.onInit();
  }
}
