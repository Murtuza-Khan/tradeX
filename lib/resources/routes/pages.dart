import '../exports/index.dart';

class Pages {
  static Transition get _routeTransition => Transition.rightToLeft;

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    Get.routing.args = settings.arguments;
    switch (settings.name) {
      case Routes.OFFLINE:
        return GetPageRoute(
          settings: settings,
          page: () => const OfflineScreen(),
          transition: _routeTransition,
        );
      case Routes.LANDING:
        return GetPageRoute(
          settings: settings,
          page: () => const Landing(),
          binding: LandingBinding(),
          transition: _routeTransition,
        );
      case Routes.LOGIN:
        return GetPageRoute(
          settings: settings,
          page: () => const Login(),
          binding: LoginBinding(),
          transition: _routeTransition,
        );
      case Routes.FORGOT_PASSWORD:
        return GetPageRoute(
          settings: settings,
          page: () => const ForgotPassword(),
          binding: ForgotPasswordBinding(),
          transition: _routeTransition,
        );
      case Routes.PASSWORD_RESET:
        return GetPageRoute(
          settings: settings,
          page: () => const PasswordReset(),
          binding: PasswordResetBinding(),
          transition: _routeTransition,
        );
      case Routes.HOME:
        return GetPageRoute(
          settings: settings,
          page: () => const Home(),
          binding: HomeBinding(),
          transition: _routeTransition,
        );
      case Routes.OTP:
        return GetPageRoute(
          settings: settings,
          page: () => const OtpScreen(),
          binding: OtpBinding(),
          transition: _routeTransition,
        );
      case Routes.ON_BOARDING:
        return GetPageRoute(
          settings: settings,
          page: () => const OnBoarding(),
          binding: OnBoardingBinding(),
          transition: _routeTransition,
        );
      case Routes.SWITCH_ACCOUNT:
        return GetPageRoute(
          settings: settings,
          page: () => const SwitchAccount(),
          binding: SwitchAccountBinding(),
          transition: _routeTransition,
        );
      case Routes.REDEEM_REWARDS:
        return GetPageRoute(
          settings: settings,
          page: () => const RedeemRewards(),
          binding: RedeemRewardsBinding(),
          transition: _routeTransition,
        );
      case Routes.USER_DASHBOARD:
        return GetPageRoute(
          settings: settings,
          page: () => const UserDashboard(),
          binding: UserDashboardBinding(),
          transition: _routeTransition,
        );
      case Routes.PROFILE:
        return GetPageRoute(
          settings: settings,
          page: () => const Profile(),
          binding: ProfileBinding(),
          transition: _routeTransition,
        );
      case Routes.REDEEM_REWARDS_HISTORY:
        return GetPageRoute(
          settings: settings,
          page: () => const RedeemRewardsHistory(),
          binding: RedeemRewardsHistoryBinding(),
          transition: _routeTransition,
        );
      case Routes.ALL_RECEIVED_POINTS:
        return GetPageRoute(
          settings: settings,
          page: () => const AllReceivedPoints(),
          binding: AllReceivedPointsBinding(),
          transition: _routeTransition,
        );
      case Routes.CHANGE_PASSWORD:
        return GetPageRoute(
          settings: settings,
          page: () => const ChangePassword(),
          binding: ChangePasswordBinding(),
          transition: _routeTransition,
        );

      default:
        return null;
    }
  }
}
