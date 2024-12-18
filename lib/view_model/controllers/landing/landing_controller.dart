import '../../../resources/exports/index.dart';

class LandingController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static final instance = Get.find<LandingController>();

  late List<BottomNavBarModel> navBarItems;

  late ScrollController scrollCtrl;

  int selectedIndex = 0;

  double animatedWidth(int index) {
    if (selectedIndex != index) return 80.0;
    if (index == 0) return 120.0;
    if (index == 1) return 150.0;
    return 170.0;
  }

  void onBackTap(BuildContext context) {
    if (selectedIndex == 1 || selectedIndex == 2) {
      selectedIndex = 0;
      Get.offNamed(Routes.HOME, id: Strings.GET_NESTED_KEY_1);
      update(['bottom_nav_bar', 'cart_count_badge']);
    } else {
      InitializationService.onWillPop(context);
    }
  }

  void onNavigate(int index, String route) {
    if (index != selectedIndex) {
      ScaffoldMessenger.of(Get.context!).clearSnackBars();
      selectedIndex = index;
      Get.offNamed(route, id: Strings.GET_NESTED_KEY_1);
      update(['bottom_nav_bar', 'cart_count_badge', 'redeem_history']);
    }
  }

  Future<void> logOut({bool shouldGotoInitialScroll = false}) async {
    CustomDialog.showConfirmationDialog(
      message: Strings.ARE_YOU_SURE,
      onTapConfirm: () async {
        await AuthManager.instance.logout();
        initialize();
        update(['bottom_nav_bar', 'side_menu_items']);
        Get.close(1);
      },
    );
  }

  void initialize() {
    navBarItems = [
      BottomNavBarModel(
        id: 0,
        title: Strings.HOME,
        icon: EneftyIcons.home_outline,
        isVisible: true,
        onTap: () => onNavigate(0, Routes.HOME),
      ),
      BottomNavBarModel(
        id: 1,
        title: Strings.REDEEME,
        icon: EneftyIcons.ticket_star_outline,
        isVisible: true,
        onTap: () => onNavigate(1, Routes.REDEEM_REWARDS),
      ),
      BottomNavBarModel(
        id: 2,
        title: Strings.DASHBOARD,
        icon: EneftyIcons.user_square_bold,
        isVisible: true,
        onTap: () => onNavigate(2, Routes.USER_DASHBOARD),
      ),
    ];
  }

  @override
  void onInit() {
    scrollCtrl = ScrollController();
    initialize();
    super.onInit();
  }
}
