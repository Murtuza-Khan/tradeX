import '../../../resources/exports/index.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 165,
          width: double.maxFinite,
          decoration: BoxDecoration(color: AppColors.backgroundColor),
        ).shimmerWidget,
        SpaceH16(),
        Row(
          children: [
            PointsCardShimmer().expanded(),
            SpaceW16(),
            PointsCardShimmer().expanded(),
          ],
        ).constrainedBox(maxHeight: 120).pdSymt(h: 16.0),
        SpaceH8(),
        _buildViewAllBtn(context).paddingAll(16.0),
        HomeCardShimmer().shadow(radius: 12.0).pdSymt(h: 16.0),
        SpaceH16(),
        HomeCardShimmer().shadow(radius: 12.0).pdSymt(h: 16.0),
        SpaceH16(),
        HomeCardShimmer().shadow(radius: 12.0).pdSymt(h: 16.0),
        SpaceH16(),
        HomeCardShimmer().shadow(radius: 12.0).pdSymt(h: 16.0),
        SpaceH16(),
        HomeCardShimmer().shadow(radius: 12.0).pdSymt(h: 16.0),
        SpaceH16(),
        HomeCardShimmer().shadow(radius: 12.0).pdSymt(h: 16.0),
        SpaceH16(),
        HomeCardShimmer().shadow(radius: 12.0).pdSymt(h: 16.0),
        SpaceH16(),
        HomeCardShimmer().shadow(radius: 12.0).pdSymt(h: 16.0),
        SpaceH16(),
        HomeCardShimmer().shadow(radius: 12.0).pdSymt(h: 16.0),
        SpaceH16(),
      ],
    );
  }

  Widget _buildViewAllBtn(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
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
}
