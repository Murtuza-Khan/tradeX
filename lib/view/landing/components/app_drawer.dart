import '../../../../resources/exports/index.dart';

class AppDrawer extends GetView<LandingController> {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310.0,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24.0),
          bottomRight: Radius.circular(24.0),
        ),
      ),
      child: SafeArea(
        child: GetBuilder<LandingController>(
          id: "side_menu_items",
          builder: (_) {
            return ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: controller.drawerItems.length,
              controller: controller.scrollCtrl,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (_, index) {
                return controller.drawerItems[index].isVisible
                    ? Column(
                        children: [
                          if (index == 0) ...[
                            const SpaceH12(),
                            _buildCloseMenuBtn(context),
                            const SpaceH12(),
                            Container(
                              height: 150.0,
                              width: double.maxFinite,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // ImageService.image(
                                  //   Assets.APP_LOGO,
                                  //   scale: 2.8,
                                  // ),
                                  const SpaceH8(),
                                  Text(
                                    Strings.APP_NAME,
                                    style: context.titleLarge.copyWith(
                                      color: AppColors.primary,
                                      fontSize: 26.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ).paddingSymmetric(horizontal: 12.0),
                            const SpaceH16(),
                          ],
                          if (controller.drawerItems[index].showDivider) ...[
                            const Divider(
                              color: AppColors.divider,
                              thickness: 1.5,
                              height: 0.0,
                            ),
                            const SpaceH30(),
                          ],
                          _buildDrawerItem(index, context),
                          if (index == controller.drawerItems.length - 1) ...[
                            const SpaceH8(),
                          ]
                        ],
                      )
                    : const SizedBox();
              },
              separatorBuilder: (_, index) =>
                  controller.drawerItems[index].isVisible
                      ? const SpaceH30()
                      : const SizedBox(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCloseMenuBtn(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GetBuilder<LandingController>(
        id: 'side_menu',
        builder: (_) => AnimatedOpacity(
          opacity: controller.isSideMenuClosed ? 0.0 : 1.0,
          duration: Duration(
            milliseconds: controller.isSideMenuClosed ? 50 : 600,
          ),
          child: CustomButton.outline(
            backgroundColor: AppColors.scaffoldBackground,
            borderColor: Colors.transparent,
            onTap: controller.toggleSideMenu,
            child: Row(
              children: [
                const SpaceW2(),
                const Icon(
                  EneftyIcons.close_circle_outline,
                  color: AppColors.primary,
                  size: 35.0,
                ),
                const SpaceW12(),
                Text(
                  "${Strings.CLOSE_MENU} >",
                  style: context.titleLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ],
            ),
          ),
        ).constrainedBox(maxHeight: 50, maxWidth: 195).paddingSymmetric(
              horizontal: 16,
            ),
      ),
    );
  }

  Widget _buildDrawerItem(int index, BuildContext context) {
    return _buildItem(index, context);
  }

  Widget _buildItem(int index, BuildContext context) {
    return GestureDetector(
      onTap: controller.drawerItems[index].onTap,
      child: Row(
        children: [
          if (controller.drawerItems[index].icon != null) ...[
            ImageService.image(
              controller.drawerItems[index].icon,
              scale: 8.0,
              imageHeight: 35,
              imageColor: controller.drawerItems[index].icon is String &&
                      controller.drawerItems[index].icon.contains('.png')
                  ? null
                  : AppColors.primary,
            ),
            const SpaceW12(),
          ],
          Text(
            controller.drawerItems[index].title,
            style: context.titleLarge.copyWith(fontWeight: FontWeight.normal),
          )
              .paddingSymmetric(
                horizontal:
                    controller.drawerItems[index].icon == null ? 6.0 : 0.0,
              )
              .expanded(),
        ],
      ).paddingSymmetric(horizontal: 12.0),
    );
  }
}
