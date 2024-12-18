import '../../../resources/exports/index.dart';

class UserDashboardController extends GetxController {
  late List<BottomNavBarModel> items;

  String get userFirstName => AuthManager.instance.user.firstName ?? "";
  String get userLastName => AuthManager.instance.user.lastName ?? "";

  String get userName =>
      "${Strings.WELCOME}, ${userFirstName.isEmpty ? Strings.SUPPLIER : "$userFirstName $userLastName"}!";

  @override
  void onInit() {
    items = [
      BottomNavBarModel(
        id: 0,
        title: Strings.PROFILE,
        icon: EneftyIcons.profile_2user_outline,
        onTap: () => Get.toNamed(Routes.PROFILE),
      ),
      BottomNavBarModel(
        id: 1,
        title: Strings.SWITCH_ACCOUNT_WBSN,
        icon: EneftyIcons.shop_outline,
        onTap: () => Get.toNamed(Routes.SWITCH_ACCOUNT),
      ),
      BottomNavBarModel(
        id: 2,
        title: Strings.REDEEMED_POINTS,
        icon: EneftyIcons.ticket_star_outline,
        onTap: () => LandingController.instance.onNavigate(
          1,
          Routes.REDEEM_REWARDS,
        ),
      ),
      BottomNavBarModel(
        id: 4,
        title: Strings.LOGOUT,
        icon: EneftyIcons.logout_2_outline,
        onTap: () => LandingController.instance.logOut(),
      ),
    ];
    super.onInit();
  }
}
