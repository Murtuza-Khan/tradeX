import '../resources/exports/index.dart';

class CustomHeroDialog extends StatelessWidget {
  final Widget child;
  final Widget dialogContent;
  final String tag;
  final double? width;
  final double? height;

  const CustomHeroDialog({
    super.key,
    required this.child,
    required this.dialogContent,
    required this.tag,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: GestureDetector(
        onTap: () => Navigator.push(
          Get.context!,
          _buildHeroDialog(tag, content: dialogContent),
        ),
        child: child,
      ),
    );
  }

  HeroDialogRoute<dynamic> _buildHeroDialog(
    String tag, {
    required Widget content,
  }) {
    return HeroDialogRoute(
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: Hero(
            tag: tag,
            child: Container(
              height:
                  height ?? (Get.height * 0.85 < 300 ? 300 : Get.height * 0.6),
              width: width ?? (Get.width < 300 ? 300 : Get.width),
              decoration: BoxDecoration(
                color: AppColors.primary.light(),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.2),
                    offset: const Offset(5.0, 5.0),
                    blurRadius: 12.0,
                  )
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  content,
                  Positioned(
                    top: -15,
                    right: -15,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary.light(),
                          border: Border.all(color: AppColors.primary),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(Sizes.PADDING_8),
                          child: Icon(
                            EneftyIcons.close_outline,
                            color: AppColors.primary,
                            size: 35,
                          ),
                        ),
                      ).constrainedBox(maxHeight: 56, maxWidth: 56),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
