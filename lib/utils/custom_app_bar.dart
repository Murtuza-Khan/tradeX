import '../resources/exports/index.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subTitle;
  final Widget? actions;
  final Widget? leading;
  final VoidCallback? onTap;
  final SystemUiOverlayStyle overlayStyle;
  final Color backgroundColor;
  final bool showLogo;
  final Color titleColor;
  final Color? subTitleColor;
  final Color? leadingIconColor;

  const CustomAppBar({
    super.key,
    this.actions,
    this.subTitle,
    this.onTap,
    this.overlayStyle = SystemUiOverlayStyle.dark,
    this.backgroundColor = AppColors.white,
    this.leading,
    this.showLogo = false,
    this.titleColor = AppColors.black,
    this.subTitleColor,
    this.leadingIconColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      systemOverlayStyle: overlayStyle,
      scrolledUnderElevation: 0.0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLogo) ...[
            // ImageService.image(Assets.APP_LOGO, scale: 3.0),
          ],
          _buildTitleAndSubTitle(context),
        ],
      ),
      centerTitle: true,
      leadingWidth: 80.0,
      leading: leading ??
          GestureDetector(
            onTap: onTap ?? Get.back,
            child: Container(
              height: 50.0,
              width: 50.0,
              color: backgroundColor,
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: titleColor,
              ),
            ),
          ),
      actions: [
        if (actions != null) ...[actions!],
      ],
    );
  }

  Column _buildTitleAndSubTitle(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: context.titleLarge.copyWith(fontSize: 20, color: titleColor),
        ),
        if (subTitle != null) ...[
          Text(
            subTitle ?? '',
            style: context.labelMedium.copyWith(
              color: subTitleColor ?? titleColor,
            ),
          ),
        ],
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
