import '../../../resources/exports/index.dart';
import 'package:path/path.dart' as p;

class ImagePickerService {
  static Future<XFile?> pickImage({
    ImageSource imageSource = ImageSource.gallery,
    double? maxWidth,
    double? maxHeight,
    int? quality,
    int maxSizeInMB = 10,
  }) async {
    try {
      final int maxFileSize = maxSizeInMB * 1024 * 1024; // 2 MB in bytes

      final XFile? image = await ImagePicker().pickImage(
        source: imageSource,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: 25,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (image != null) {
        String ext = p.extension(image.path);
        if (image.mimeType == 'image/jpeg' ||
            image.mimeType == 'image/jpg' ||
            image.mimeType == 'image/png' ||
            image.mimeType == 'image/webp' ||
            image.mimeType == 'image/svg' ||
            ext == ".jpg" ||
            ext == ".jpeg" ||
            ext == ".png" ||
            ext == ".webp" ||
            ext == "svg") {
          int imageSize = await image.length();
          if (imageSize > maxFileSize) {
            CustomSnackBar.errorToast(
              message: "Image size is grater than $maxSizeInMB MB",
            );
            return null;
          }
          return image;
        } else {
          CustomSnackBar.toast(message: 'Invalid File Format.');
        }
      }
    } on PlatformException catch (_) {
      CustomSnackBar.errorToast(message: "Failed to pick Image.");
    }
    return null;
  }

  static Future<XFile?> showImagePickerSheet(BuildContext context) async {
    XFile? image;

    image = await CustomSnackBar.showCustomBottomSheet<XFile?>(
      color: context.scaffoldBackgroundColor,
      showDivider: false,
      maxHeight: 160,
      maxWidth: 500,
      bottomSheet: _buildImagePickerContent(),
    );

    return image;
  }

  static Widget _buildImagePickerContent() {
    XFile? image;

    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          ListTile(
            onTap: () async {
              image = await pickImage(imageSource: ImageSource.camera);
              Get.back<XFile>(result: image);
            },
            leading: Icon(
              Icons.camera_alt_outlined,
              color: AppColors.primary,
            ),
            title: Text(Strings.FROM_CAMERA, style: Get.context!.bodyLarge),
          ),
          ListTile(
            onTap: () async {
              image = await pickImage(imageSource: ImageSource.gallery);
              Get.back<XFile>(result: image);
            },
            leading: Icon(Icons.image_outlined, color: AppColors.primary),
            title: Text(Strings.FROM_GALLERY, style: Get.context!.bodyLarge),
          ),
        ],
      ),
    );
  }
}
