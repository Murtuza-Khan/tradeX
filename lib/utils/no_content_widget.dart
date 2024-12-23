import '../resources/exports/index.dart';

class NoContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final double padding;
  final bool showBackground;

  const NoContent({
    super.key,
    required this.title,
    required this.subtitle,
    this.padding = 0,
    this.showBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: showBackground ? const Radius.circular(55) : Radius.zero,
          bottomRight: showBackground ? const Radius.circular(55) : Radius.zero,
        ),
        child: Container(
          color: showBackground ? AppColors.white : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: padding),
                  Text(
                    title,
                    style: Get.textTheme.headlineLarge!.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black.withValues(alpha: 0.45),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      subtitle,
                      style: Get.textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black.withValues(alpha: 0.45),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
