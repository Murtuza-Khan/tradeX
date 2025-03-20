import '../../resources/exports/index.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: Strings.LOGIN, leading: SizedBox()),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageService.image(Assets.LOGIN_SCREEN_LOGO, scale: 3.5).clipRRect(
                  radius: BorderRadius.circular(120),
                ),
                SpaceH16(),
                Text(
                  Strings.LOGIN_INTO_YOUR_ACCOUNT,
                  style: context.headlineSmall.copyWith(
                    color: AppColors.primary,
                    fontSize: 30.0,
                  ),
                ),
                const SpaceH10(),
                Text(
                  "${Strings.WELCOME} ${Strings.TO_DELTA}",
                  style: context.titleMedium.copyWith(
                    color: AppColors.disabled,
                  ),
                ),
                const SpaceH20(),
                const LoginForm(),
                const SpaceH20(),
              ],
            ).paddingSymmetric(horizontal: 16.0),
          ),
        ),
      ),
    );
  }
}
