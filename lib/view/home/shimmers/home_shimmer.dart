import '../../../resources/exports/index.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            PointsCardShimmer().expanded(),
            SpaceW16(),
            PointsCardShimmer().expanded(),
          ],
        ).constrainedBox(maxHeight: 120),
        SpaceH20(),
        _buildViewAllBtn(context),
        SpaceH16(),
        _buildCardShimmer().shadow(radius: 12.0),
        SpaceH16(),
        _buildCardShimmer().shadow(radius: 12.0),
        SpaceH16(),
        _buildCardShimmer().shadow(radius: 12.0),
        SpaceH16(),
        _buildCardShimmer().shadow(radius: 12.0),
        SpaceH16(),
        _buildCardShimmer().shadow(radius: 12.0),
        SpaceH16(),
        _buildCardShimmer().shadow(radius: 12.0),
        SpaceH16(),
        _buildCardShimmer().shadow(radius: 12.0),
        SpaceH16(),
        _buildCardShimmer().shadow(radius: 12.0),
        SpaceH16(),
        _buildCardShimmer().shadow(radius: 12.0),
        SpaceH16(),
      ],
    );
  }

  Widget _buildViewAllBtn(BuildContext context) {
    return Container(
      color: AppColors.background,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitlePlaceholder(width: 150, linesCount: 1).shimmerWidget,
          Container(
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitlePlaceholder(width: 63, linesCount: 1).shimmerWidget,
                const SpaceW4(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.white,
                  size: 18,
                ).shimmerWidget,
              ],
            ),
          ).shadow(radius: 5.0),
        ],
      ),
    );
  }

  Container _buildCardShimmer() {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: AppColors.disabled,
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
            _buildTitleAndSubTitle(),
            SpaceH12(),
            _buildTitleAndSubTitle(icon: EneftyIcons.calendar_outline),
            SpaceH12(),
            _buildTitleAndSubTitle(icon: EneftyIcons.gift_outline),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndSubTitle({IconData? icon}) {
    return Row(
      children: [
        Icon(
          icon ?? EneftyIcons.user_octagon_outline,
          color: AppColors.white,
          size: 28,
        ).shimmerWidget,
        SpaceW8(),
        Row(
          children: [
            TitlePlaceholder(
              width: 100,
              height: 10,
              linesCount: 1,
            ).shimmerWidget,
            SpaceW12(),
            TitlePlaceholder(width: 100, linesCount: 1)
                .shimmerWidget
                .expanded(),
          ],
        ).expanded(),
      ],
    );
  }
}
