part of 'extensions.dart';

extension WidgetExtensions on Widget {
  RepaintBoundary get repaintBoundary => RepaintBoundary(child: this);

  ShowUpAnimation showUp({
    int delayDurationInMilli = 0,
    int durationInMilli = 400,
  }) {
    return ShowUpAnimation(
      delayStart: Duration(milliseconds: delayDurationInMilli),
      animationDuration: Duration(milliseconds: durationInMilli),
      curve: Curves.linear,
      direction: Direction.horizontal,
      offset: -0.5,
      child: this,
    );
  }

  Widget align({AlignmentGeometry? align}) {
    return Align(alignment: align ?? Alignment.center, child: this);
  }

  Widget shadow({
    double radius = 35.0,
    Color? color,
    Offset? offset,
    double? blurRadius,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: color ?? AppColors.black.withOpacity(0.2),
            offset: offset ?? const Offset(0.0, 4.0),
            blurRadius: blurRadius ?? 5.0,
          ),
        ],
      ),
      child: this,
    );
  }

  Widget pdAll({double pd = 0.0}) {
    return Padding(padding: EdgeInsets.all(pd), child: this);
  }

  Widget pdSymt({double h = 0.0, v = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
      child: this,
    );
  }

  Widget pdOnly({double l = 0.0, r = 0.0, t = 0.0, b = 0.0}) {
    return Padding(
      padding: EdgeInsets.only(top: t, bottom: b, left: l, right: r),
      child: this,
    );
  }

  Widget scale({double scale = 1.0}) {
    return Transform.scale(scale: scale, child: this);
  }

  Widget expanded({int flex = 1, bool enabled = true}) =>
      enabled ? Expanded(flex: flex, child: this) : this;

  Widget flexible({
    int flex = 1,
    FlexFit fit = FlexFit.loose,
    bool enabled = true,
  }) =>
      enabled ? Flexible(flex: flex, fit: fit, child: this) : this;

  ConstrainedBox constrainedBox({
    double maxWidth = 450,
    double minWidth = 450,
    double maxHeight = double.infinity,
    double minHeight = 200,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
      child: this,
    );
  }

  MouseRegion get mouseRegion => MouseRegion(
        cursor: SystemMouseCursors.click,
        child: this,
      );

  Shimmer get shimmerWidget => Shimmer.fromColors(
        baseColor: const Color.fromRGBO(0, 0, 0, 0.1),
        highlightColor: const Color(0x44CCCCCC),
        enabled: true,
        child: this,
      );

  PopScope get popScope => PopScope(
        canPop: false,
        onPopInvokedWithResult: (_, __) =>
            Get.back(id: Strings.GET_NESTED_KEY_1),
        child: this,
      );

  FadeSlideTransition fadeScaleTransition({
    int delay = 0,
    AnimDirection direction = AnimDirection.bottomToTop,
    Duration duration = Durations.short2,
  }) {
    return FadeSlideTransition(
      animationDirection: direction,
      duration: duration,
      delay: delay,
      child: this,
    );
  }

  Widget handleException({
    Widget? second,
    required Widget errorWidget,
  }) {
    try {
      return this;
    } catch (e) {
      try {
        return second ?? errorWidget;
      } catch (e) {
        return errorWidget;
      }
    }
  }

  PreferredSize get preferredSize {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: this,
    );
  }

  SliverToBoxAdapter get sliverToBoxAdapter => SliverToBoxAdapter(child: this);

  SliverFillViewport get sliverFillViewPort => SliverFillViewport(
        delegate: SliverChildListDelegate(
          [this],
        ),
      );

  SliverFillRemaining get sliverFillRemaining => SliverFillRemaining(
        hasScrollBody: true,
        fillOverscroll: true,
        child: this,
      );
}

extension TextStyleX on TextStyle {
  /// A method to underline a text with a customizable [distance] between the text
  /// and underline. The [color], [thickness] and [style] can be set
  /// as the decorations of a [TextStyle].
  TextStyle underlined({
    Color? color,
    double distance = 1,
    double thickness = 1,
    TextDecorationStyle style = TextDecorationStyle.solid,
  }) {
    return copyWith(
      shadows: [
        Shadow(
          color: this.color ?? Colors.black,
          offset: Offset(0, -distance),
        )
      ],
      color: Colors.transparent,
      decoration: TextDecoration.underline,
      decorationThickness: thickness,
      decorationColor: color ?? this.color,
      decorationStyle: style,
    );
  }
}

extension EdgeInsetsX on EdgeInsets {
  EdgeInsets except({
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? vertical,
    double? horizontal,
  }) {
    return copyWith(
      top: vertical ?? top ?? this.top,
      bottom: vertical ?? bottom ?? this.bottom,
      left: horizontal ?? left ?? this.left,
      right: horizontal ?? right ?? this.right,
    );
  }
}
