import '../resources/exports/index.dart';

class CustomLoading {
  static SpinKitThreeBounce get spinKitThreeBouncePrimary => SpinKitThreeBounce(
        color: Get.theme.primaryColor,
        size: Sizes.HEIGHT_20,
      );
  static SpinKitThreeBounce get spinKitThreeBounceWhite => const SpinKitThreeBounce(
        color: AppColors.white,
        size: Sizes.HEIGHT_20,
      );
}
