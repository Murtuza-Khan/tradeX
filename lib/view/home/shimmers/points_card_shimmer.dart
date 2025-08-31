import '../../../resources/exports/index.dart';

class PointsCardShimmer extends StatelessWidget {
  final IconData? icon;
  const PointsCardShimmer({super.key, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.0,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.white,
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
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: AppColors.white,
                  size: 30,
                ).shimmerWidget,
              ).shimmerWidget,
              SpaceW8(),
              TitlePlaceholder(
                width: 100,
                height: 10,
                linesCount: 1,
              ).shimmerWidget.expanded(),
            ],
          ),
          SpaceH8(),
          TitlePlaceholder(
            width: 100,
            height: 10,
            linesCount: 1,
          ).shimmerWidget.expanded(),
        ],
      ),
    ).shadow(radius: 12.0, offset: Offset(0.0, 2.0));
  }
}
