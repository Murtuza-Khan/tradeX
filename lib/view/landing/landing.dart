import '../../resources/exports/index.dart';

class Landing extends GetView<LandingController> {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, __) => controller.onBackTap(context),
      canPop: false,
      child: Container(
        color: AppColors.scaffoldBackground,
        child: Stack(
          fit: StackFit.expand,
          children: [
            GetBuilder<LandingController>(
              id: "side_menu",
              builder: (_) {
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 350),
                  left: controller.isSideMenuClosed ? -300 : 0,
                  curve: Curves.fastOutSlowIn,
                  top: 0,
                  bottom: 0,
                  width: 300,
                  child: const AppDrawer().shadow(
                    offset: const Offset(0.0, 0.0),
                    radius: 24.0,
                    blurRadius: 8.0,
                  ),
                );
              },
            ),
            GetBuilder<LandingController>(
              id: "side_menu",
              builder: (_) {
                return Transform.translate(
                  offset: Offset(controller.animation.value * (280), 0),
                  child: Transform.scale(
                    scale: controller.scaleAnimation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          controller.isSideMenuClosed ? 0 : 24.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            controller.isSideMenuClosed ? 0 : 24.0,
                          ),
                        ),
                        child: _buildContent(context),
                      ),
                    ).shadow(
                      offset: const Offset(0.0, 0.0),
                      radius: 24.0,
                      blurRadius: 8.0,
                    ),
                  ).repaintBoundary,
                ).repaintBoundary;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _buildAppBar(context),
      body: GestureDetector(
        onTap: () => controller.isSideMenuClosed
            ? () {}
            : controller.toggleSideMenu.call(),
        child: AbsorbPointer(
          absorbing: !controller.isSideMenuClosed,
          child: _buildNavigator(),
        ).constrainedBox(maxHeight: double.maxFinite),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Navigator _buildNavigator() {
    return Navigator(
      key: Get.nestedKey(Strings.GET_NESTED_KEY_1),
      onGenerateRoute: Pages.onGenerateRoute,
      initialRoute: Routes.HOME,
    );
  }

  CustomAppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: '',
      onTap: () {},
      showLogo: true,
      leading: GestureDetector(
        onTap: () => controller.toggleSideMenu.call(),
        child: const Icon(Icons.menu, color: AppColors.primary, size: 28),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return CustomShadow(
      sigma: 4,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: SizedBox(
          width: double.maxFinite,
          height: 100.0,
          child: GetBuilder<LandingController>(
            id: 'bottom_nav_bar',
            builder: (_) => Row(
              children: List.generate(
                controller.navBarItems.length,
                (index) => controller.navBarItems[index].isVisible
                    ? _buildNavBarItem(index, context).expanded()
                    : const SizedBox(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavBarItem(int index, BuildContext context) {
    return GestureDetector(
      onTap: controller.navBarItems[index].onTap,
      child: Container(
        color: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              controller.navBarItems[index].icon,
              color: controller.selectedIndex == index
                  ? AppColors.primary
                  : AppColors.primary.withOpacity(0.7),
              size: controller.selectedIndex == index ? 30 : 28,
            ),
            const SpaceH6(),
            Text(
              controller.navBarItems[index].title,
              style: context.titleMedium.copyWith(
                color: controller.selectedIndex == index
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.7),
                fontWeight: controller.selectedIndex == index
                    ? FontWeight.bold
                    : FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
