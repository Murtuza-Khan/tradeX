import '../../resources/exports/index.dart';

class Profile extends GetView<ProfileController> {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.PROFILE),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomFutureBuilder(
          future: ProfileRepository.getUserProfile(),
          data: (profile) {
            controller.profile = profile ?? ProfileModel();
            controller.onGetProfile();
          },
          hasDataBuilder: (_, __) {
            return Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    controller: controller.nameCtrl,
                    fillColor: AppColors.white,
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
                  ),
                  SpaceH12(),
                  CustomTextFormField(
                    controller: controller.emailCtrl,
                    fillColor: AppColors.white,
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
                  CustomButton.solid(
                    backgroundColor: AppColors.primary,
                    textColor: AppColors.white,
                    text: Strings.UPDATE,
                    onTapAsync: () async {},
                    radius: Sizes.RADIUS_12,
                    constraints: const BoxConstraints(minHeight: 55),
                  ),
                ],
              ).paddingSymmetric(horizontal: 16.0),
            );
          },
        ),
      ),
    );
  }
}
