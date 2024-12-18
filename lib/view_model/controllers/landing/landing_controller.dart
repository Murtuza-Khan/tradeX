import '../../../resources/exports/index.dart';

class LandingController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static final instance = Get.find<LandingController>();

  late List<BottomNavBarModel> navBarItems;
  late List<BottomNavBarModel> drawerItems;

  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  late ScrollController scrollCtrl;

  bool isSideMenuClosed = true;

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

  Future<void> toggleSideMenu() async {
    isSideMenuClosed = !isSideMenuClosed;
    if (isSideMenuClosed) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
    update(['side_menu']);
  }

  void onNavigate(int index, String route) {
    if (index != selectedIndex) {
      ScaffoldMessenger.of(Get.context!).clearSnackBars();
      selectedIndex = index;
      Get.offNamed(route, id: Strings.GET_NESTED_KEY_1);
      update(['bottom_nav_bar', 'cart_count_badge']);
    }
  }

  Future<void> logOut({bool shouldGotoInitialScroll = false}) async {
    CustomDialog.showConfirmationDialog(
      message: Strings.ARE_YOU_SURE,
      onTapConfirm: () async {
        await AuthManager.instance.logout();
        initialize();
        if (!isSideMenuClosed) await toggleSideMenu();
        if (shouldGotoInitialScroll) scrollCtrl.jumpTo(0.0);
        update(['bottom_nav_bar', 'cart_count_badge', 'side_menu_items']);
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

    drawerItems = [
      BottomNavBarModel(
        id: 1,
        title: Strings.HOME,
        icon: EneftyIcons.home_2_outline,
        isVisible: true,
        onTap: () {
          toggleSideMenu();
          onNavigate(0, Routes.HOME);
        },
      ),
    ];
  }

  @override
  void onInit() {
    scrollCtrl = ScrollController();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 1.0,
    )..addListener(() => update(['side_menu']));

    animation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );

    scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    );

    initialize();
    super.onInit();
  }
}
