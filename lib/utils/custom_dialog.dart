import '../resources/exports/index.dart';

class CustomDialog {
  static const Duration animationDuration = Durations.medium3;

  static Future<T?> showDialog<T>({
    required Widget content,
    bool barrierDismissible = true,
    double? width,
    double? height,
    Alignment? alignment,
    bool showTopRightDialog = false,
    EdgeInsets? margin,
    String? title,
    Widget? footer,
    bool isDialogScrollable = false,
    bool showSendButton = false,
    VoidCallback? onSave,
    String? saveButtonText,
  }) {
    return showGeneralDialog<T>(
      context: Get.context!,
      barrierLabel: '',
      barrierDismissible: barrierDismissible,
      transitionDuration: animationDuration,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return showTopRightDialog
            ? PanaraAnimations.fromLeft(animation, secondaryAnimation, child)
            : PanaraAnimations.grow(animation, secondaryAnimation, child);
      },
      pageBuilder: (animation, secondaryAnimation, child) {
        var buildDialogContent = _buildDialogContent(title, content, footer,
            height, width, alignment, showSendButton, onSave, saveButtonText);

        return Padding(
          padding: margin ?? EdgeInsets.zero,
          child: isDialogScrollable
              ? Center(child: SingleChildScrollView(child: buildDialogContent))
              : buildDialogContent,
        );
      },
    );
  }

  static Widget _buildDialogContent(
    String? title,
    Widget content,
    Widget? footer,
    double? height,
    double? width,
    Alignment? alignment,
    bool showSendButton,
    VoidCallback? onSave,
    String? saveButtonText,
  ) {
    return buildDialogContainer(
      child: Column(
        children: [
          if (title != null) ...[
            buildDialogHeader(
              title: title,
              onSave: onSave,
              saveButtonText: saveButtonText,
              showSendButton: showSendButton,
            ),
            const Divider(color: AppColors.divider, height: 1),
          ],
          content.expanded(),
          if (footer != null) ...[
            const Divider(color: AppColors.divider, height: 1),
            footer,
          ]
        ],
      ),
      height: height,
      width: width,
      alignment: alignment,
    );
  }

  static Widget buildDialogHeader({
    required String title,
    VoidCallback? onSave,
    String? saveButtonText,
    required bool showSendButton,
  }) {
    return SizedBox(
      width: double.maxFinite,
      height: 50,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: Sizes.PADDING_6,
            child: GestureDetector(
              onTap: Get.back,
              child: const Padding(
                padding: EdgeInsets.only(right: Sizes.PADDING_8),
                child: Icon(
                  EneftyIcons.close_outline,
                  color: Color(0xFF817272),
                  size: Sizes.ICON_SIZE_30,
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              title,
              style: Get.context!.titleLarge.copyWith(
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          if (onSave != null) ...[
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: TextButton(
                  onPressed: onSave,
                  child: Text(
                    saveButtonText ??
                        (showSendButton ? Strings.SEND : Strings.SAVE),
                    style: Get.context!.titleMedium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static void showConfirmationDialog({
    String? title,
    required String message,
    String? imagePath,
    String? confirmButtonText,
    String? cancelButtonText,
    required VoidCallback onTapConfirm,
    VoidCallback? onTapCancel,
    PanaraDialogType? panaraDialogType,
    Color? color,
    Color? textColor,
    Color? buttonTextColor,
    EdgeInsets? padding,
    bool noImage = false,
    double? width,
    double? height,
    bool barrierDismissible = true,
  }) {
    showGeneralDialog(
      context: Get.context!,
      barrierLabel: '',
      barrierDismissible: barrierDismissible,
      transitionDuration: animationDuration,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return PanaraAnimations.grow(animation, secondaryAnimation, child);
      },
      pageBuilder: (animation, secondaryAnimation, child) {
        return buildDialogContainer(
          child: PanaraConfirmDialogWidget(
            title: title,
            message: message,
            confirmButtonText: confirmButtonText ?? "Yes",
            cancelButtonText: cancelButtonText ?? "No",
            color: color ?? AppColors.primary,
            onTapCancel: onTapCancel ?? Get.back,
            onTapConfirm: onTapConfirm,
            panaraDialogType: panaraDialogType ?? PanaraDialogType.custom,
            textColor: textColor,
            buttonTextColor: buttonTextColor,
            imagePath: imagePath,
            margin: EdgeInsets.zero,
            padding: padding,
            noImage: noImage,
          ),
          height: height,
          width: width,
        );
      },
    );
  }

  static Future<void> showInfoDialog({
    String? title,
    TextStyle? titleTextStyle,
    TextOverflow titleTextOverFlow = TextOverflow.ellipsis,
    int titleMaxLines = 4,
    required String message,
    TextStyle? messageTextStyle,
    TextOverflow messageTextOverFlow = TextOverflow.ellipsis,
    int messageMaxLines = 4,
    String? imagePath,
    String? buttonText,
    VoidCallback? onTapDismiss,
    PanaraDialogType? panaraDialogType,
    Color? color,
    Color? textColor,
    Color? buttonTextColor,
    EdgeInsets? padding,
    bool noImage = false,
    double? width,
    double? height,
    bool barrierDismissible = true,
  }) async {
    await showGeneralDialog(
      context: Get.context!,
      barrierLabel: '',
      barrierDismissible: barrierDismissible,
      transitionDuration: animationDuration,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return PanaraAnimations.grow(animation, secondaryAnimation, child);
      },
      pageBuilder: (animation, secondaryAnimation, child) {
        return buildDialogContainer(
          child: PanaraInfoDialogWidget(
            title: title,
            titleTextStyle: titleTextStyle,
            titleMaxLines: titleMaxLines,
            titleTextOverFlow: titleTextOverFlow,
            message: message,
            messageTextStyle: messageTextStyle,
            messageMaxLines: messageMaxLines,
            messageTextOverFlow: messageTextOverFlow,
            buttonText: buttonText ?? "Ok",
            color: color ?? Get.context!.primaryColor,
            onTapDismiss: onTapDismiss ?? Get.back,
            panaraDialogType: panaraDialogType ?? PanaraDialogType.custom,
            textColor: textColor,
            buttonTextColor: buttonTextColor,
            imagePath: imagePath,
            margin: EdgeInsets.zero,
            padding: padding,
            noImage: noImage,
          ),
          height: height,
          width: width,
        );
      },
    );
  }

  static Dialog buildDialogContainer({
    required Widget child,
    double? width,
    double? height,
    Alignment? alignment,
  }) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_16),
      alignment: alignment ?? Alignment.center,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.RADIUS_6),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: width ?? 340,
          maxHeight: height ?? 340,
          minWidth: width ?? 340,
          minHeight: height ?? 340,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Sizes.RADIUS_6),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.RADIUS_6),
          child: child,
        ),
      ),
    );
  }
}
