import '../../../resources/exports/index.dart';

class HomeCardShimmer extends StatelessWidget {
  const HomeCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
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
