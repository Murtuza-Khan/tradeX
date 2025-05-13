import '../../resources/exports/index.dart';

class Profile extends GetView<ProfileController> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.PROFILE),
      backgroundColor: AppColors.backgroundColor,
      body: FocusScope(
        node: controller.focusScopeNode,
        child: SafeArea( 
          child: Form(
            key: controller.formKey,
            child: GetBuilder<ProfileController>(
              id: 'profile_widget',
              builder: (_) {
                return CustomFutureBuilder(
                  customLoader: CustomLoading.spinKitThreeBouncePrimary,
                  future: controller.onGetProfile(),
                  hasDataBuilder: (_,__) {
                    return _buildProfileWidget(context);
                  },
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  Center _buildProfileWidget(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildProfileImage(context),
            SpaceH20(),
            CustomTextFormField(
              controller: controller.firstNameCtrl,
              textCapitalization: TextCapitalization.none,
              isRequired: true,
              height: Sizes.HEIGHT_20,
              labelText: Strings.NAME,
              labelColor: AppColors.black,
              prefixIcon: EneftyIcons.user_outline,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primary,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              validator: Validators.isValidString.call,
              onChanged: (_) {
                controller.toggleUpdateProfileBtnEnaled.call();
              },
            ),
            SpaceH12(),
            CustomTextFormField(
              controller: controller.lastNameCtrl,
              textCapitalization: TextCapitalization.none,
              isRequired: true,
              height: Sizes.HEIGHT_20,
              labelText: Strings.LAST_NAME,
              labelColor: AppColors.black,
              prefixIcon: EneftyIcons.user_outline,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primary,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              validator: Validators.isValidString.call,
              onChanged: (_) {
                controller.toggleUpdateProfileBtnEnaled.call();
              },
            ),
            SpaceH12(),
            CustomTextFormField(
              controller: controller.emailCtrl,
              textCapitalization: TextCapitalization.none,
              isRequired: true,
              height: Sizes.HEIGHT_20,
              labelText: Strings.EMAIL,
              labelColor: AppColors.black,
              prefixIcon: EneftyIcons.sms_outline,
              prefixIconColor: AppColors.black,
              textColor: AppColors.black,
              cursorColor: AppColors.black,
              enableBorderColor: AppColors.black,
              focusBorderColor: AppColors.primary,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.emailValidator.call,
              onChanged: (_) {
                controller.toggleUpdateProfileBtnEnaled.call();
              },
            ),
            SpaceH16(),
            Stack(
              children: [
                IntlPhoneField(
                  showDropdownIcon: false,
                  flagsButtonMargin: EdgeInsets.only(left: 16),
                  dropdownTextStyle: context.titleMedium.copyWith(
                    color: AppColors.disabled,
                  ),
                  enabled: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                    labelText: Strings.PHONE_NUMBER,
                    labelStyle: context.titleMedium.copyWith(
                      fontWeight: FontWeight.normal,
                      color: AppColors.disabled,
                    ),
                  ),
                  readOnly: true,
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: controller.phoneCtrl,
                  keyboardType: TextInputType.number,
                  initialCountryCode: 'PK',
                  languageCode: "en",
                  onChanged: (phone) {},
                  onCountryChanged: (country) => controller.country = country,
                  inputFormatters: InputFormat.onlyNumber,
                ),
                Container(
                  width: double.maxFinite,
                  height: 65,
                  color: Colors.transparent,
                ),
              ],
            ),
            const SpaceH18(),
            Obx(
              () => CustomButton.solid(
                isEnabled: controller.isUpdateProfileBtnEnabled.value,
                backgroundColor: controller.isUpdateProfileBtnEnabled.value
                    ? AppColors.primary
                    : AppColors.disabled,
                textColor: AppColors.white,
                text: Strings.UPDATE,
                onTapAsync: () async => controller.updateProfile(),
                radius: Sizes.RADIUS_12,
                constraints: const BoxConstraints(minHeight: 55),
              ),
            ),
            if (controller.focusScopeNode.hasFocus) ...[SpaceH96()]
          ],
        ).paddingSymmetric(horizontal: 16.0),
      ),
    );
  }

  Container _buildProfileImage(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.0),
      height: 180.0,
      width: 180.0,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Container(
        height: 178,
        width: 178,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            GetBuilder<ProfileController>(
              id: 'profile_image',
              builder: (_) {
                return Center(
                  child: controller.imageBytes != null
                      ? CustomHeroDialog(
                          tag: "profile_memory_image",
                          dialogContent: _buildMemoryImage(fit: BoxFit.contain),
                          child: _buildMemoryImage().clipRRect(
                            radius: BorderRadius.circular(90.0),
                          ),
                        )
                      : CustomHeroDialog(
                          tag: "profile_network_image",
                          dialogContent: _buildNetworkImage(
                            fit: BoxFit.contain,
                            radius: 10.0,
                          ),
                          child: _buildNetworkImage(),
                        ),
                );
              },
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: PreventMultiTap(
                onSafeTap: () => controller.pickFile(context),
                child: Container(
                  padding: EdgeInsets.all(1.5),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 50,
                    width: 50,
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: AppColors.primary.light(),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      EneftyIcons.edit_outline,
                      color: AppColors.primary,
                    ),
                  ).shadow(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkImage({BoxFit fit = BoxFit.cover, double radius = 90.0}) {
    return ImageService.image(
      controller.profileImage,
      imageHeight: 180,
      imageWidth: 180,
      borderRadius: radius,
      fit: fit,
    );
  }

  Widget _buildMemoryImage({BoxFit fit = BoxFit.cover}) {
    return Image.memory(
      controller.imageBytes!,
      height: 180,
      width: 180,
      fit: fit,
    );
  }
}
