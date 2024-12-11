import '../resources/exports/index.dart';

class CustomImageWidget extends StatelessWidget {
  final String imageUrl;
  final XFile? imageFile;
  final BoxFit? fit;
  final double? borderRadius;
  final double imageHeight;
  final double? imageWidth;
  final double? scale;

  const CustomImageWidget({
    super.key,
    required this.imageUrl,
    this.imageFile,
    this.fit,
    this.borderRadius,
    this.imageHeight = Sizes.ICON_SIZE_50 + 20,
    this.imageWidth,
    this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 95),
      child: imageFile != null
          ? _buildFileImage()
          : SizedBox(
              height: imageHeight,
              width: imageWidth ?? imageHeight,
              child: imageUrl.isNotEmpty &&
                      imageUrl !=
                          "https://bazaritaza.com/public/assets/img/placeholder.jpg"
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: fit,
                            image: imageProvider,
                            scale: scale ?? 1.0,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => _buildPlaceHolder(),
                      errorWidget: (context, url, error) => _buildErrorWidget(),
                      fit: fit ?? BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl:
                          "https://bazaritaza.com/public/assets/img/placeholder.jpg",
                      placeholder: (context, url) => _buildPlaceHolder(),
                      errorWidget: (context, url, error) => _buildErrorWidget(),
                      fit: BoxFit.cover,
                    ),
            ),
    );
  }

  Container _buildErrorWidget() {
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        child: const Icon(Icons.error_outline),
      ),
    );
  }

  Widget _buildPlaceHolder() {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.white,
    ).shimmerWidget;
  }

  Widget _buildFileImage() {
    return SizedBox(
      height: imageHeight,
      width: imageHeight,
      child: Image.file(
        key: ValueKey(GlobalHelper.getRandomId()),
        File(imageFile!.path),
        fit: fit ?? BoxFit.cover,
        errorBuilder: (context, _, __) => _buildPlaceHolder(),
      ),
    );
  }
}
