import '../../resources/exports/index.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(title: "", leading: SizedBox()),
      body: Container(
        margin: EdgeInsets.only(
          bottom: Platform.isAndroid ? 16.0 : 45.0,
        ),
        decoration: BoxDecoration(color: AppColors.white),
        child: CustomFutureBuilder(
          future: HomeRepository.getCompanies(),
          data: (companies) => controller.companies = companies ?? [],
          hasDataBuilder: (_, __) {
            return Column(
              children: [
                supplierDetails(context),
                SpaceH30(),
                GetBuilder<HomeController>(
                  id: "refresh_home_data",
                  builder: (_) => CustomCarouselSlider(
                    apiUrl: Urls.SLIDERS,
                    refreshData: controller.refreshBanners,
                  ),
                ).paddingSymmetric(horizontal: 6),
                SpaceH20(),
                Row(
                  children: [
                    _buildColorCard(
                      context,
                      title: GlobalHelper.formatedNumber(
                        value: controller.selectedCompany.points ?? 0,
                      ),
                      subTitle: Strings.TOTAL_POINTS,
                      icon: EneftyIcons.star_outline,
                    ).expanded(),
                    SpaceW8(),
                    _buildColorCard(
                      context,
                      title: Strings.SWITCH_ACCOUNT,
                      icon: EneftyIcons.profile_2user_outline,
                      cardColor: AppColors.switchAccCard,
                      iconSize: 38,
                      onTap: () => Get.toNamed(
                        Routes.SWITCH_ACCOUNT,
                        arguments: {"companies": controller.companies},
                      ),
                    ).expanded(),
                  ],
                ).paddingSymmetric(horizontal: 16.0),
                SpaceH8(),
                Row(
                  children: [
                    _buildColorCard(
                      context,
                      title: Strings.PROFILE,
                      icon: EneftyIcons.user_outline,
                      cardColor: AppColors.profileCard,
                    ).expanded(),
                    SpaceW8(),
                    _buildColorCard(
                      context,
                      title: Strings.REDEEM_POINTS,
                      icon: EneftyIcons.gift_outline,
                      cardColor: AppColors.redeemedCard,
                    ).expanded(),
                  ],
                ).paddingSymmetric(horizontal: 16.0),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget supplierDetails(BuildContext context) {
    return CustomShadow(
      opacity: 0.4,
      offset: const Offset(0.0, 4.0),
      sigma: 7.0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: -15,
            child: ClipPath(
              clipper: SinWaveClipper(),
              child: Container(
                height: 270,
                width: double.maxFinite,
                color: AppColors.primary,
              ),
            ),
          ),
          ClipPath(
            clipper: SinWaveClipper(),
            child: Container(
              height: 270,
              width: double.maxFinite,
              color: AppColors.primaryLight,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: kToolbarHeight + 40),
                  Text(
                    "${Strings.HI}, ${AuthManager.instance.user.firstName?.capitalizeFirst ?? "Supplier"}${AuthManager.instance.user.lastName == null ? "" : " "}${AuthManager.instance.user.lastName?.capitalizeFirst ?? ""}!",
                    style: context.headlineSmall.copyWith(
                      color: AppColors.primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    Strings.HERE_YOU,
                    style: context.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SpaceH8(),
                  CustomRichText(
                    "${Strings.ACCOUNT}: ",
                    style: context.titleLarge,
                    children: [
                      TextSpan(
                        text: "${controller.selectedCompany.name}",
                        style: context.headlineSmall
                            .copyWith(color: AppColors.primary),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorCard(
    BuildContext context, {
    Color? cardColor,
    String? title,
    String? subTitle,
    IconData? icon,
    double? iconSize,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150.0,
        decoration: BoxDecoration(
          color: cardColor ?? AppColors.pointsCard,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.white, size: iconSize ?? 35),
            SpaceW8(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? '-',
                  style: context.headlineSmall.copyWith(
                    color: AppColors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (subTitle != null) ...[
                  Text(
                    subTitle,
                    style: context.titleLarge.copyWith(color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
