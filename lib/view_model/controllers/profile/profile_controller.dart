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

  late ProfileModel? profile;

  Future<void> getProfile() async {
    profile = await ProfileRepository.getProfile();
  }

  Future<ProfileModel?> onGetProfile() async {
    await getProfile();
    firstNameCtrl.text = profile?.firstName?.capitalizeFirstLetter ?? "";
    lastNameCtrl.text = profile?.lastName?.capitalizeFirstLetter ?? "";
    phoneCtrl.text = profile?.phone ?? "";
    if (phoneCtrl.text.isNotEmpty &&
        phoneCtrl.text.startsWith("0") &&
        phoneCtrl.text.length >= 11) {
      phoneCtrl.text = phoneCtrl.text.substring(1);
    }
    emailCtrl.text = profile?.email ?? "";
    profileImage = profile?.profileImage ?? "";

    return profile;
  }

  void toggleUpdateProfileBtnEnaled() {
    if (firstNameCtrl.text.trim() == profile?.firstName &&
        lastNameCtrl.text.trim() == profile?.lastName &&
        emailCtrl.text.trim() == profile?.email &&
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
          "client_id": AuthManager.instance.company.id,
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
        update(['profile_widget']);
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
    super.onInit();
  }
}
