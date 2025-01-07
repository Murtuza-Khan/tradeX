import '../resources/exports/index.dart';

enum ButtonType { outline, solid, dotted }

enum ButtonStyleX { concave, convex, none }

class CustomButton extends StatefulWidget {
  final ButtonType buttonType;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? loaderColor;

  final String? text;
  final TextStyle? textStyle;
  final Color? textColor;
  final FontWeight? fontWeight;
  final String? secondaryText;
  final TextStyle? secondaryTextStyle;

  final Widget? icon;
  final bool showIconOnRight;
  final double iconSpacing;

  final VoidCallback? onTap;
  final AsyncCallback? onTapAsync;

  final double radius;
  final double borderWidth;

  final bool hasInfiniteWidth;
  final BoxConstraints? constraints;

  final EdgeInsets? padding;
  final EdgeInsetsGeometry? margin;

  final bool isLoading;
  final Widget? loadingWidget;

  final bool isEnabled;

  final Widget? child;

  final List<double>? dashPattern;

  final Color? splashColor;

  final ButtonStyleX style;
  final double? blurRadius;
  final Offset? offset;
  final Color? topLeftColor;
  final Color? bottomRightColor;

  const CustomButton({
    super.key,
    this.backgroundColor,
    this.child,
    this.text,
    this.textStyle,
    this.textColor,
    this.fontWeight,
    this.secondaryText,
    this.secondaryTextStyle,
    this.icon,
    this.showIconOnRight = false,
    this.iconSpacing = Sizes.PADDING_12,
    this.isLoading = false,
    this.loadingWidget,
    this.onTap,
    this.onTapAsync,
    this.hasInfiniteWidth = true,
    this.constraints,
    this.radius = Sizes.RADIUS_14,
    this.padding,
    this.margin,
    this.buttonType = ButtonType.solid,
    this.borderWidth = 0,
    this.borderColor,
    this.dashPattern,
    this.splashColor,
    this.loaderColor,
    this.style = ButtonStyleX.none,
    this.blurRadius,
    this.offset,
    this.topLeftColor,
    this.bottomRightColor,
    this.isEnabled = true,
  }) : assert(
          (textStyle == null || textColor == null) &&
              (textStyle == null || fontWeight == null),
          'Cannot provide both a textStyle, a textColor and a fontWeight\n'
          'To provide custom, use "textStyle: TextStyle()".',
        );

  const CustomButton.solid({
    super.key,
    this.backgroundColor,
    this.child,
    this.text,
    this.textStyle,
    this.textColor,
    this.fontWeight,
    this.secondaryText,
    this.secondaryTextStyle,
    this.icon,
    this.showIconOnRight = false,
    this.iconSpacing = Sizes.PADDING_12,
    this.isLoading = false,
    this.loadingWidget,
    this.onTap,
    this.onTapAsync,
    this.hasInfiniteWidth = true,
    this.constraints,
    this.radius = Sizes.RADIUS_14,
    this.padding,
    this.margin,
    this.borderWidth = 0,
    this.borderColor,
    this.splashColor,
    this.loaderColor,
    this.style = ButtonStyleX.none,
    this.blurRadius,
    this.offset,
    this.topLeftColor,
    this.bottomRightColor,
    this.isEnabled = true,
  })  : buttonType = ButtonType.solid,
        dashPattern = null,
        assert(
          (textStyle == null || textColor == null) &&
              (textStyle == null || fontWeight == null),
          'Cannot provide both a textStyle, a textColor and a fontWeight\n'
          'To provide custom, use "textStyle: TextStyle()".',
        );

  const CustomButton.outline({
    super.key,
    this.backgroundColor,
    this.child,
    this.text,
    this.textStyle,
    this.textColor,
    this.fontWeight,
    this.secondaryText,
    this.secondaryTextStyle,
    this.icon,
    this.showIconOnRight = false,
    this.iconSpacing = Sizes.PADDING_12,
    this.borderColor,
    this.isLoading = false,
    this.loadingWidget,
    this.onTap,
    this.onTapAsync,
    this.hasInfiniteWidth = true,
    this.constraints,
    this.radius = Sizes.RADIUS_14,
    this.borderWidth = 1.5,
    this.padding,
    this.margin,
    this.splashColor,
    this.loaderColor,
    this.isEnabled = true,
  })  : buttonType = ButtonType.outline,
        dashPattern = null,
        blurRadius = null,
        offset = null,
        topLeftColor = null,
        bottomRightColor = null,
        style = ButtonStyleX.none,
        assert(
          (textStyle == null || textColor == null) &&
              (textStyle == null || fontWeight == null),
          'Cannot provide both a textStyle, a textColor and a fontWeight\n'
          'To provide custom, use "textStyle: TextStyle()".',
        );

  const CustomButton.dotted({
    super.key,
    this.backgroundColor,
    this.child,
    this.text,
    this.textStyle,
    this.textColor,
    this.fontWeight,
    this.secondaryText,
    this.secondaryTextStyle,
    this.icon,
    this.showIconOnRight = false,
    this.iconSpacing = Sizes.PADDING_12,
    this.borderColor,
    this.dashPattern,
    this.isLoading = false,
    this.loadingWidget,
    this.onTap,
    this.onTapAsync,
    this.hasInfiniteWidth = true,
    this.constraints,
    this.radius = Sizes.RADIUS_14,
    this.borderWidth = 1.5,
    this.padding,
    this.margin,
    this.splashColor,
    this.loaderColor,
    this.style = ButtonStyleX.none,
    this.blurRadius,
    this.offset,
    this.topLeftColor,
    this.bottomRightColor,
    this.isEnabled = true,
  })  : buttonType = ButtonType.dotted,
        assert(
          (textStyle == null || textColor == null) &&
              (textStyle == null || fontWeight == null),
          'Cannot provide both a textStyle, a textColor and a fontWeight\n'
          'To provide custom style, use "textStyle: TextStyle()".',
        );

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  late bool isLoading = false;

  Future<void> asyncOnTap() async {
    try {
      if (widget.onTapAsync != null) {
        if (mounted) setState(() => isLoading = true);
        await widget.onTapAsync!();
        if (mounted) setState(() => isLoading = false);
      } else {
        if (widget.onTap != null) widget.onTap!();
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  bool get showLoading =>
      widget.isLoading || (widget.onTapAsync != null && isLoading);

  // Do not allow Tap when loading
  AsyncCallback? get onTap => !showLoading ? asyncOnTap : null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: ConstrainedBox(
        constraints: widget.hasInfiniteWidth
            ? BoxConstraints(
                minWidth: double.infinity,
                minHeight: widget.constraints?.minHeight ?? 50,
              )
            : widget.constraints ??
                const BoxConstraints(minWidth: 100, minHeight: 50),
        child: _buildButton(context),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    TextStyle style = context.titleMedium.copyWith(
      color: widget.textColor,
      fontWeight: widget.fontWeight ?? FontWeight.w500,
    );
    TextStyle style2 = context.titleSmall.copyWith(
      color: widget.textColor,
      fontWeight: widget.fontWeight ?? FontWeight.w400,
    );

    Widget child = showLoading
        ? _buildLoadingWidget()
        : widget.child ??
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (widget.icon != null && !widget.showIconOnRight)
                    widget.icon!,
                  if (widget.text != null || widget.secondaryText != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        if (widget.icon != null && !widget.showIconOnRight)
                          SizedBox(width: widget.iconSpacing),
                        if (widget.text != null)
                          Text(
                            widget.text!,
                            style: widget.textStyle ?? style,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        if (widget.secondaryText != null) ...[
                          const SpaceW4(),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: Sizes.PADDING_2),
                            child: Text(
                              widget.secondaryText!,
                              style: widget.secondaryTextStyle ?? style2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                        if (widget.icon != null && widget.showIconOnRight)
                          SizedBox(width: widget.iconSpacing),
                      ],
                    ),
                  if (widget.icon != null && widget.showIconOnRight)
                    widget.icon!,
                ],
              ),
            );

    return child;
  }

  TextButton _buildSolidButton({required Widget child}) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        foregroundColor: AppColors.secondary,
        padding: widget.padding ?? EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          side: BorderSide(
            color: widget.borderColor ?? Colors.transparent,
            width: widget.borderWidth,
          ),
        ),
        minimumSize: widget.constraints.minSize,
        maximumSize: widget.constraints.maxSize,
      ),
      onPressed: widget.isEnabled ? onTap : null,
      child: child,
    );
  }

  OutlinedButton _buildOutlinedButton({required Widget child}) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          width: widget.borderWidth,
          color:
              widget.borderColor ?? widget.backgroundColor ?? AppColors.primary,
        ),
        padding: widget.padding ?? EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          side: BorderSide(
            color: widget.backgroundColor ?? AppColors.primary,
          ),
        ),
        minimumSize: widget.constraints.minSize,
        maximumSize: widget.constraints.maxSize,
      ),
      onPressed: widget.isEnabled ? onTap : null,
      child: child,
    );
  }

  Widget _buildDottedButton({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius),
          ),
          padding: EdgeInsets.zero,
        ),
        onPressed: widget.isEnabled ? (!isLoading ? onTap : null) : null,
        child: DottedBorder(
          borderType: BorderType.RRect,
          color:
              widget.borderColor ?? widget.backgroundColor ?? AppColors.primary,
          radius: Radius.circular(widget.radius),
          dashPattern: const [6, 4],
          strokeWidth: widget.borderWidth,
          borderPadding: const EdgeInsets.all(Sizes.PADDING_2),
          child: Container(
            constraints: widget.constraints,
            padding: widget.padding ?? EdgeInsets.zero,
            decoration: BoxDecoration(
              color: (widget.backgroundColor ?? AppColors.primary)
                  .withValues(alpha: 0.3),
              borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    switch (widget.buttonType) {
      case ButtonType.outline:
        return _buildOutlinedButton(child: _buildChild(context));

      case ButtonType.solid:
        return _buildSolidButton(child: _buildChild(context));

      case ButtonType.dotted:
        return _buildDottedButton(child: _buildChild(context));
    }
  }

  Widget _buildLoadingWidget() {
    double size = (widget.constraints?.minHeight ?? 50) <= 40 ? 20 : 30;
    return widget.loadingWidget ??
        SizedBox(
          height: size,
          width: size,
          child: GlobalHelper.loadingWidget(),
        );
  }
}

extension SizeX on BoxConstraints? {
  Size get minSize => Size(this?.minWidth ?? 0.0, this?.minHeight ?? 0.0);

  Size get maxSize => Size(this?.maxWidth ?? 0.0, this?.maxHeight ?? 0.0);
}

// To call the button on Tap manually for loading functionality
extension GestureDetect on GlobalKey {
  void get onTap async {
    try {
      RenderBox renderBox = currentContext!.findRenderObject() as RenderBox;

      Offset position = renderBox.localToGlobal(Offset.zero);
      double x = position.dx;
      double y = position.dy;

      GestureBinding.instance.handlePointerEvent(
        PointerDownEvent(position: Offset(x, y)),
      ); // trigger button up,

      await Future.delayed(Durations.short1);
      // add delay between up and down button

      GestureBinding.instance.handlePointerEvent(
        PointerUpEvent(position: Offset(x, y)),
      ); // trigger button down
    } catch (e) {
      log.e(e.toString());
    }
  }
}
