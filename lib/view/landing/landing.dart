import '../../resources/exports/index.dart';

class Landing extends GetView<LandingController> {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, __) => controller.onBackTap(context),
      canPop: false,
      child: Scaffold(
        extendBody: true,
        appBar: _buildAppBar(context),
        body: Navigator(
          key: Get.nestedKey(Strings.GET_NESTED_KEY_1),
          onGenerateRoute: Pages.onGenerateRoute,
          initialRoute: Routes.HOME,
        ).constrainedBox(maxHeight: double.maxFinite),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  CustomAppBar _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: '',
      onTap: () {},
      showLogo: true,
      leading: SizedBox(),
      actions: Row(
        children: [
          _buildAppBarActions(
            context,
            onTap: () => Get.toNamed(Routes.SWITCH_ACCOUNT),
          ),
          GetBuilder<LandingController>(
            id: "redeem_history",
            builder: (_) => controller.selectedIndex == 1
                ? _buildAppBarActions(
                    context,
                    icon: EneftyIcons.book_outline,
                    onTap: () {},
                  ).showUp()
                : SizedBox(),
          ),
          SpaceW8(),
        ],
      ).showUp(),
    );
  }

  Widget _buildAppBarActions(
    BuildContext context, {
    VoidCallback? onTap,
    IconData? icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Icon(
          icon ?? EneftyIcons.shop_outline,
          color: AppColors.primary,
          size: 35,
        ),
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
        child: Container(
          width: double.maxFinite,
          height: 100.0,
          color: AppColors.white,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: GetBuilder<LandingController>(
            id: 'bottom_nav_bar',
            builder: (_) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                controller.navBarItems.length,
                (index) => controller.navBarItems[index].isVisible
                    ? _buildNavBarItem(index, context)
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
      child: AnimatedContainer(
        duration: Durations.medium1,
        width: controller.animatedWidth(index),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: controller.selectedIndex == index
              ? AppColors.primaryLight
              : AppColors.white,
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                controller.navBarItems[index].icon,
                color: controller.selectedIndex == index
                    ? AppColors.primary
                    : AppColors.primary.withOpacity(0.7),
                size: 33,
              ),
              const SpaceW6(),
              if (controller.selectedIndex == index) ...[
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
                ),
              ],
            ],
          ),
        ),
      )
          .shadow(
            radius: 35.0,
            color:
                controller.selectedIndex == index ? null : Colors.transparent,
          )
          .paddingOnly(bottom: 12.0),
    );
  }
}
