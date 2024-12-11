import '../../resources/exports/index.dart';

class SignUp extends GetView<SignUpController> {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: Strings.SIGNUP),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.SIGNUP_CREATE_ACCOUNT,
                style: context.headlineSmall.copyWith(
                  color: AppColors.primary,
                  fontSize: 30.0,
                ),
              ),
              const SpaceH20(),
              Text(
                Strings.WELCOME,
                style: context.titleMedium.copyWith(color: AppColors.disabled),
              ),
              const SpaceH30(),
              const SignUpForm(),
            ],
          ).paddingSymmetric(horizontal: 16.0),
        ),
      ),
    );
  }
}
