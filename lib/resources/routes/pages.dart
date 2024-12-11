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
      case Routes.SIGNUP:
        return GetPageRoute(
          settings: settings,
          page: () => const SignUp(),
          binding: SignUpBinding(),
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

      default:
        return null;
    }
  }
}
