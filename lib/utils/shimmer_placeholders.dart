import 'dart:math';

import '../resources/exports/index.dart';

class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.boxShape,
  });

  final double? width;
  final double? height;
  final double? borderRadius;
  final BoxShape? boxShape;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: boxShape == null
            ? BorderRadius.circular(borderRadius ?? 12.0)
            : null,
        color: Colors.white,
        shape: boxShape ?? BoxShape.rectangle,
      ),
    );
  }
}

class TitlePlaceholder extends StatelessWidget {
  final double width;
  final double height;
  final int linesCount;
  final EdgeInsets padding;

  const TitlePlaceholder({
    super.key,
    required this.width,
    this.linesCount = 2,
    this.height = 12.0,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: padding,
        itemBuilder: (_, index) {
          return Container(
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 8.0),
        itemCount: linesCount,
      ),
    );
  }
}

class RichTitlePlaceholder extends StatelessWidget {
  final double width;
  final double height;
  final int linesCount;
  final EdgeInsets padding;
  final CrossAxisAlignment crossAxisAlignment;

  const RichTitlePlaceholder({
    super.key,
    required this.width,
    this.linesCount = 2,
    this.height = 12.0,
    this.padding = EdgeInsets.zero,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: List.generate(
          linesCount,
          (index) => Column(
            children: [
              _buildLine(height, width * ((Random().nextInt(4) + 6) / 10)),
              const SpaceH8(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildLine(double height, double width) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
    ),
  );
}

enum ContentLineType {
  twoLines,
  threeLines,
}

class ContentPlaceholder extends StatelessWidget {
  final ContentLineType lineType;

  const ContentPlaceholder({
    super.key,
    required this.lineType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 96.0,
            height: 72.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                if (lineType == ContentLineType.threeLines)
                  Container(
                    width: double.infinity,
                    height: 10.0,
                    margin: const EdgeInsets.only(bottom: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                Container(
                  width: 100.0,
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BusinessHorizontalListViewShimmer extends StatelessWidget {
  final double? heightOfListView;

  const BusinessHorizontalListViewShimmer({
    super.key,
    this.heightOfListView,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          children: [
            _buildContent(context),
            const SpaceW20(),
            _buildContent(context),
            const SpaceW20(),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Container _buildContent(BuildContext context) {
    return Container(
      width: 340,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            offset: const Offset(0.0, 4.0),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.white,
              height:
                  heightOfListView != null ? heightOfListView! * 0.55 : 150.0,
            ).shimmerWidget,
            const SpaceH8(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const Icon(
                    EneftyIcons.save_2_bold,
                    color: AppColors.white,
                  ).shimmerWidget,
                  const SpaceW8(),
                  const TitlePlaceholder(width: 120, height: 10, linesCount: 1)
                      .shimmerWidget,
                  const SpaceW12(),
                  const Icon(
                    EneftyIcons.location_bold,
                    color: AppColors.white,
                  ).shimmerWidget,
                  const SpaceW8(),
                  const TitlePlaceholder(
                    width: 120,
                    height: 10,
                    linesCount: 1,
                  ).shimmerWidget,
                ],
              ),
            ),
            const SpaceH4(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: const TitlePlaceholder(
                width: 220,
                height: 10,
                linesCount: 2,
              ).shimmerWidget,
            ),
            const SpaceH4(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  const TitlePlaceholder(
                    width: 50,
                    height: 10,
                    linesCount: 1,
                  ).shimmerWidget,
                  const SpaceW12(),
                  _buildIconAndText(context),
                  const SpaceW8(),
                  _buildIconAndText(
                    context,
                    icon: EneftyIcons.eye_bold,
                  ),
                ],
              ),
            ),
            const SpaceH8(),
          ],
        ),
      ),
    );
  }

  Widget _buildIconAndText(BuildContext context, {IconData? icon}) {
    return Row(
      children: [
        Icon(
          icon ?? EneftyIcons.like_bold,
          color: AppColors.white,
        ).shimmerWidget,
        const SpaceW4(),
        const TitlePlaceholder(
          width: 50,
          height: 10,
          linesCount: 1,
        ).shimmerWidget,
      ],
    );
  }
}

class HorizontalListViewShimmer extends StatelessWidget {
  const HorizontalListViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.HEIGHT_250,
      child: ListView.separated(
        itemCount: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.symmetric(vertical: Sizes.PADDING_20),
          width: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: _buildCardContent().shimmerWidget,
        ),
        separatorBuilder: (_, index) => const SpaceW20(),
      ),
    );
  }

  Widget _buildCardContent() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(color: Colors.white, height: 150, width: double.maxFinite),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.PADDING_6,
              vertical: Sizes.PADDING_8,
            ),
            child: Column(
              children: [
                TitlePlaceholder(width: 120, height: 10, linesCount: 1),
                SpaceH12(),
                TitlePlaceholder(width: 120, height: 10, linesCount: 1),
              ],
            ),
          ),
          const SpaceH4(),
        ],
      ),
    );
  }
}

class GridViewShimmer extends StatelessWidget {
  const GridViewShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      addRepaintBoundaries: true,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: Sizes.WIDTH_18,
      mainAxisSpacing: Sizes.HEIGHT_20,
      childAspectRatio: 3 / 3.1,
      children: [
        _buildCardContent(),
        _buildCardContent(),
        _buildCardContent(),
        _buildCardContent(),
        _buildCardContent(),
        _buildCardContent(),
        _buildCardContent(),
        _buildCardContent(),
      ],
    );
  }

  Widget _buildCardContent() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: double.maxFinite,
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.PADDING_6,
                vertical: Sizes.PADDING_8,
              ),
              child: Column(
                children: [
                  TitlePlaceholder(width: 120, height: 10, linesCount: 1),
                  SpaceH12(),
                  TitlePlaceholder(width: 120, height: 10, linesCount: 1),
                ],
              ),
            ),
            const SpaceH4(),
          ],
        ),
      ),
    ).shimmerWidget;
  }
}

class CountDownTimerShimmer extends StatelessWidget {
  const CountDownTimerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitlePlaceholder(width: 200, height: 20, linesCount: 1)
            .shimmerWidget,
        const SpaceH20(),
        const TitlePlaceholder(width: 250, height: 20, linesCount: 1)
            .shimmerWidget,
        const SpaceH12(),
        SlideCountdownSeparated(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(5.0),
          ),
          duration: const Duration(days: 2),
        ).shimmerWidget,
        const SpaceH12(),
      ],
    );
  }
}
