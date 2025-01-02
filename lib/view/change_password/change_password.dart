import '../../resources/exports/index.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.CHANGE_PASSWORD),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Strings.CHANGE_PASSWORD,
            style: context.headlineSmall.copyWith(
              color: AppColors.primary,
              fontSize: 30.0,
            ),
          ),
          const SpaceH8(),
          Text(
            Strings.TO_CHANGE_PASSWORD,
            style: context.titleMedium.copyWith(
              color: AppColors.disabled,
            ),
          ),
          SpaceH20(),
          ChangePasswordForm(),
          SpaceH20(),
          CustomButton.solid(
            backgroundColor: AppColors.primary,
            textColor: AppColors.white,
            text: Strings.PROCEED,
            onTapAsync: () async {},
            radius: Sizes.RADIUS_12,
            constraints: const BoxConstraints(minHeight: 55),
          ),
        ],
      ).paddingAll(16.0),
    );
  }
}
