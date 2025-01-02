import 'package:tradex/dummy/redeem_rewards_history_data.dart';
import '../../resources/exports/index.dart';

class RedeemRewardsHistory extends StatelessWidget {
  const RedeemRewardsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.REDEEME_HISTORY),
      body: CustomPagination<RedeemHistory>(
        backgroundColor: AppColors.background,
        apiUrl: Urls.LOGIN,
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: Platform.isAndroid ? 20 : 45,
        ),
        initList: RedeemHistory.listFromJson,
        dummyData: redeemRewardsHistory,
        separator: SpaceH16(),
        shimmer: (_) => RedeemRewardsHistoryShimmer(),
        shouldRefreshList: (_) => true,
        child: (_, index, __, ___, item) {
          return _buildHistoryCard(context, item).shadow(radius: 12.0);
        },
      ),
    );
  }

  Container _buildHistoryCard(BuildContext context, RedeemHistory history) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 5.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleAndSubTitle(
              context,
              subTitle: history.requestId,
              icon: EneftyIcons.security_card_outline,
            ),
            SpaceH12(),
            _buildTitleAndSubTitle(
              context,
              title: Strings.DATE,
              icon: EneftyIcons.calendar_outline,
              subTitle: history.createdDate?.format(
                pattern: "dd-MMM-yyyy, hh:mm a",
              ),
            ),
            SpaceH12(),
            _buildTitleAndSubTitle(
              context,
              title: Strings.POINTS_REDEEMED,
              icon: EneftyIcons.gift_outline,
              subTitle: (history.points ?? 0).getFormattedCurrency(
                showSymbol: false,
              ),
            ),
            SpaceH12(),
            _buildTitleAndSubTitle(
              context,
              title: Strings.VOUCHER_CODE,
              subTitle: history.voucherCode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndSubTitle(
    BuildContext context, {
    String? title,
    String? subTitle,
    IconData? icon,
  }) {
    return Row(
      children: [
        Icon(
          icon ?? EneftyIcons.ticket_2_outline,
          color: AppColors.primary,
        ),
        SpaceW8(),
        CustomRichText(
          "${title ?? Strings.REQUEST_ID} : ",
          style: context.labelLarge.copyWith(
            color: AppColors.primary,
          ),
          children: [
            TextSpan(
              text: subTitle ?? '-',
              style: context.titleLarge.copyWith(
                fontSize: 16.0,
              ),
            ),
          ],
        ).expanded(),
      ],
    );
  }
}
