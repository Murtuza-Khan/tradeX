import '../../resources/exports/index.dart';

class UserDashboard extends GetView<UserDashboardController> {
  const UserDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.maxFinite,
        color: AppColors.background,
        child: Column(
          children: [
            _buildWelcomeHeader(context),
            const SpaceH20(),
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: controller.items.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: controller.items[index].onTap,
                  child: Container(
                    color: AppColors.background,
                    child: Column(
                      children: [
                        const Divider(color: AppColors.divider, thickness: 1.5),
                        Row(
                          children: [
                            Icon(
                              controller.items[index].icon,
                              color: index == controller.items.length - 1
                                  ? AppColors.error
                                  : AppColors.primary,
                              size: 38.0,
                            ),
                            const SpaceW16(),
                            Text(
                              controller.items[index].title,
                              style: context.titleLarge.copyWith(
                                color: index == controller.items.length - 1
                                    ? AppColors.error
                                    : AppColors.primary,
                                fontSize: 20,
                              ),
                            ).expanded(),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.primary,
                              size: 28.0,
                            ),
                          ],
                        ).paddingSymmetric(vertical: 12.0),
                      ],
                    ),
                  ),
                );
              },
            ).expanded(),
            const SpaceH110(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader(BuildContext context) {
    return Container(
      height: 120.0,
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            controller.userName,
            style: context.headlineSmall.copyWith(color: AppColors.primary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(Strings.HERE_YOU, style: context.titleMedium),
        ],
      ),
    ).shadow(radius: 14.0).paddingAll(16.0);
  }
}
