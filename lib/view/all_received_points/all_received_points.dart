import '../../dummy/received_points_data.dart';
import '../../resources/exports/index.dart';

class AllReceivedPoints extends StatelessWidget {
  const AllReceivedPoints({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.RECEIVED_POINTS),
      body: CustomPagination<ReceivedPointsDataModel>(
        apiUrl: Urls.CATEGORIES,
        backgroundColor: AppColors.background,
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: Platform.isAndroid ? 20 : 45,
        ),
        separator: SpaceH16(),
        initList: ReceivedPointsDataModel.listFromJson,
        dummyData: receivedPointsData['received_points'],
        showSearchBar: true,
        shimmer: (_) => HomeCardShimmer().shadow(radius: 12.0),
        shouldRefreshList: (_) => true,
        child: (_, index, __, ___, item) {
          return _buildCard(context, item).shadow(radius: 12.0);
        },
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
}
