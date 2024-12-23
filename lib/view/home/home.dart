import '../../resources/exports/index.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.black,
      onRefresh: () async => controller.update(["refresh_home_data"]),
      child: Container(
        margin: EdgeInsets.only(bottom: Platform.isAndroid ? 16.0 : 45.0),
        decoration: BoxDecoration(color: AppColors.background),
        child: GetBuilder<HomeController>(
          id: 'refresh_home_data',
          builder: (_) {
            return CustomFutureBuilder(
              future: HomeRepository.getReceivedPoints(),
              customLoader: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: HomeShimmer().paddingAll(16.0),
              ),
              data: (receivedPoints) => controller.receivedPoints =
                  receivedPoints ?? ReceivedPointsModel(),
              hasDataBuilder: (_, __) => _buildReceivedPointsList(context),
            );
          },
        ),
      ),
    );
  }

  Widget _buildReceivedPointsList(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: Platform.isAndroid ? 105 : 80,
      ),
      itemCount: controller.receivedPoints.receivedPoints?.length ?? 0,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, index) {
        return Column(
          children: [
            if (index == 0) ...[
              Row(
                children: [
                  _buildPointsCard(
                    context,
                    title: Strings.TOTAL_POINTS,
                    subTitle: GlobalHelper.formatedNumber(
                      value: controller.receivedPoints.totalPoints ?? 0,
                    ),
                    icon: EneftyIcons.star_outline,
                  ).expanded(),
                  SpaceW16(),
                  _buildPointsCard(
                    context,
                    title: Strings.REDEEMED_POINTS,
                    cardColor: AppColors.primaryLight,
                    subTitle: GlobalHelper.formatedNumber(
                      value: controller.receivedPoints.redeemedPoints ?? 0,
                    ),
                    icon: EneftyIcons.ticket_star_outline,
                  ).expanded(),
                ],
              ),
              SpaceH24(),
              _buildViewAllBtn(context),
              SpaceH16(),
            ],
            _buildCard(
              context,
              (controller.receivedPoints.receivedPoints ?? [])[index],
            ).shadow(radius: 12.0),
          ],
        );
      },
      separatorBuilder: (_, __) => SpaceH16(),
    );
  }

  Widget _buildViewAllBtn(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Row(
        children: [
          CustomText(
            Strings.RECEIVED_POINTS,
            style: context.titleLarge.copyWith(color: AppColors.primary),
          ).expanded(),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.ALL_RECEIVED_POINTS),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                children: [
                  CustomText(
                    Strings.VIEW_ALL,
                    style: context.titleMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const SpaceW4(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.primary,
                    size: 18,
                  )
                ],
              ),
            ).shadow(radius: 5.0),
          ),
        ],
      ),
    );
  }

  Container _buildCard(
    BuildContext context,
    ReceivedPointsDataModel summary,
  ) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: AppColors.primary,
      ),
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleAndSubtitle(
              context,
              title: Strings.ISSUED_BY,
              subTitle: summary.from ?? '-',
            ),
            SpaceH12(),
            _buildTitleAndSubtitle(
              context,
              title: Strings.DATE,
              icon: EneftyIcons.calendar_outline,
              subTitle: summary.dateTime?.format(
                pattern: "dd-MMM-yyyy, hh:mm a",
              ),
            ),
            SpaceH12(),
            _buildTitleAndSubtitle(
              context,
              title: Strings.POINTS,
              icon: EneftyIcons.gift_outline,
              subTitle: (summary.points ?? 0).getFormattedCurrency(
                showSymbol: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle(
    BuildContext context, {
    String? title,
    String? subTitle,
    IconData? icon,
  }) {
    return Row(
      children: [
        Icon(
          icon ?? EneftyIcons.user_octagon_outline,
          color: AppColors.primary,
          size: 28,
        ),
        SpaceW8(),
        CustomRichText(
          "${title ?? "-"} : ",
          style: context.titleSmall.copyWith(
            color: AppColors.primary,
          ),
          children: [
            TextSpan(text: subTitle ?? '-', style: context.titleMedium),
          ],
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ).expanded(),
      ],
    );
  }

  Widget _buildPointsCard(
    BuildContext context, {
    Color? cardColor,
    String? subTitle,
    String? title,
    IconData? icon,
  }) {
    return Container(
      height: 110.0,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: cardColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: cardColor == null
                      ? AppColors.primaryLight
                      : AppColors.black,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: cardColor == null ? AppColors.black : AppColors.white,
                  size: 30,
                ),
              ).shadow(radius: 90.0),
              SpaceW8(),
              Text(
                title ?? '-',
                style: context.labelLarge.copyWith(fontWeight: FontWeight.w600),
                maxLines: 2,
              ).expanded(),
            ],
          ),
          SpaceH8(),
          if (subTitle != null) ...[
            Text(
              subTitle,
              style: context.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    ).shadow(radius: 12.0, offset: Offset(0.0, 2.0));
  }
}
