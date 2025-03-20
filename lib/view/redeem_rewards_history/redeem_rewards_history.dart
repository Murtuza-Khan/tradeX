import '../../resources/exports/index.dart';

class RedeemRewardsHistory extends GetView<RedeemRewardsHistoryController> {
  const RedeemRewardsHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.REDEEME_HISTORY),
      body: CustomPagination<RedeemHistory>(
        backgroundColor: AppColors.backgroundColor,
        apiUrl: Urls.REDEEM_HISTORY,
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 12,
          bottom: Platform.isAndroid ? 20 : 45,
        ),
        initList: RedeemHistory.listFromJson,
        separator: SpaceH16(),
        shimmer: (_) => RedeemRewardsHistoryShimmer(),
        shouldRefreshList: (_) => true,
        child: (_, index, __, ___, item) {
          return _buildHistoryCard(context, item).shadow(radius: 12.0);
        },
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, RedeemHistory history) {
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
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
            ).expanded(),
            GestureDetector(
              onTap: () {
                CustomDialog.showConfirmationDialog(
                  message: "Do you have the Giftkarte app installed?",
                  onTapConfirm: () async => controller.onConfirmDeepLinkTap(),
                  onTapCancel: () async => controller.onCancleDeepLinkTap(),
                );
              },
              child: Container(
                color: Colors.transparent,
                child: Icon(
                  EneftyIcons.link_3_bold,
                  color: AppColors.primary,
                  size: 35,
                ),
              ),
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
