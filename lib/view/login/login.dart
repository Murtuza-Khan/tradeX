import '../../resources/exports/index.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: Strings.LOGIN),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Strings.LOGIN_INTO_YOUR_ACCOUNT,
                  style: context.headlineSmall.copyWith(
                    color: AppColors.primary,
                    fontSize: 30.0,
                  ),
                ),
                const SpaceH20(),
                Text(
                  Strings.WELCOME,
                  style:
                      context.titleMedium.copyWith(color: AppColors.disabled),
                ),
                const SpaceH30(),
                const LoginForm(),
                const SpaceH30(),
              ],
            ).paddingSymmetric(horizontal: 16.0),
          ),
        ),
      ),
    );
  }
}
