import '../../resources/exports/index.dart';

class Profile extends GetView<ProfileController> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.PROFILE),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageService.image(
                    AuthManager.instance.company.logo,
                    imageHeight: 150,
                    imageWidth: 150,
                  ),
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
                        onCountryChanged: (country) =>
                            controller.country = country,
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
                      backgroundColor:
                          controller.isUpdateProfileBtnEnabled.value
                              ? AppColors.primary
                              : AppColors.disabled,
                      textColor: AppColors.white,
                      text: Strings.UPDATE,
                      onTapAsync: () async => controller.updateProfile(),
                      radius: Sizes.RADIUS_12,
                      constraints: const BoxConstraints(minHeight: 55),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
