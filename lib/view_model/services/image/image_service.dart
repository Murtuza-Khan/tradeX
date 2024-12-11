import '../../../resources/exports/index.dart';

class ImageService {
  static Widget image(
    dynamic image, {
    double? borderRadius,
    double? imageHeight,
    double? imageWidth,
    Color? imageColor,
    BoxFit fit = BoxFit.cover,
    double? scale,
  }) {
    if (image is IconData) {
      return Icon(
        image,
        color: imageColor ?? AppColors.white,
        size: imageHeight,
      );
    } else if (image.contains("http") || image.contains("https")) {
      return CustomImageWidget(
        imageUrl: image,
        borderRadius: borderRadius,
        imageHeight: imageHeight ?? 70,
        imageWidth: imageWidth,
        fit: scale != null ? null : fit,
        scale: image == null ? 2.0 : scale,
      );
    } else if (image.startsWith('/') || image.contains('/cache/')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 95),
        child: Image.file(
          File(image),
          width: imageWidth,
          height: imageHeight ?? 70,
          fit: scale != null ? null : fit,
          scale: image == null ? 2.0 : scale ?? 1.0,
        ),
      );
    } else {
      return Image.asset(
        image.isEmpty || image == null ? Assets.APP_LOGO : image,
        color: imageColor,
        fit: scale != null ? null : fit,
        scale: image == null ? 2.0 : scale,
      );
    }
  }
}
