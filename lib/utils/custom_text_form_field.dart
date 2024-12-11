import '../resources/exports/index.dart';

class CustomTextFormField extends StatelessWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final String? validationKey;

  final FocusNode? focusNode;
  final bool? autofocus;

  final String? labelText;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Color? labelColor;
  final TextStyle? labelStyle;

  final String? hintText;
  final TextStyle? hintStyle;

  final bool? readOnly;
  final bool? enabled;
  final bool isRequired;

  /// To hide [password]
  final bool? obscureText;
  final String obscuringCharacter;
  final String requiredLabelCharacter;
  final Color? requiredLabelColor;

  final BoxConstraints? prefixIconConstraints;
  final Widget? prefixWidget;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final double? prefixIconSize;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final double? suffixIconSize;
  final Color? suffixIconColor;

  final void Function(String?)? onChanged;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onSuffixTap;
  final VoidCallback? onTap;
  final void Function(String?)? onSave;
  final void Function(String?)? onFieldSubmit;

  final int? maxLines;
  final int? maxLength;

  final String? Function(String?)? validator;
  final String? requiredErrorMessage;
  final List<TextInputFormatter>? inputFormatters;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;

  final Color? textColor;
  final TextStyle? textStyle;

  final Color? fillColor;
  final Color? cursorColor;
  final Color? errorColor;

  final TextCapitalization? textCapitalization;

  final double height;
  final double? width;
  final double verticalPadding;

  final Color? enableBorderColor;
  final Color? focusBorderColor;
  final Color? errorBorderColor;
  final Color? disableBorderColor;
  final double? borderRadius;

  final bool onTapSelectAll;

  final double? errorFontSize;
  final InputDecoration? inputDecoration;
  final bool showValidator;
  final BorderRadius? customBorderRadius;

  final TextAlign textAlign;

  const CustomTextFormField({
    super.key,
    this.initialValue,
    this.validationKey,
    this.controller,
    this.isRequired = false,
    this.requiredLabelColor,
    this.requiredLabelCharacter = '*',
    this.labelText,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.labelColor,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    this.prefixIcon,
    this.prefixIconSize,
    this.prefixIconColor,
    this.prefixIconConstraints,
    this.prefixWidget,
    this.suffixIcon,
    this.suffixWidget,
    this.suffixIconSize,
    this.suffixIconColor,
    this.obscureText,
    this.obscuringCharacter = '*',
    this.onChanged,
    this.onSuffixTap,
    this.validator,
    this.requiredErrorMessage,
    this.onSave,
    this.inputFormatters,
    this.textInputAction,
    this.autofillHints,
    this.keyboardType,
    this.onEditingComplete,
    this.onFieldSubmit,
    this.readOnly,
    this.focusNode,
    this.maxLines,
    this.maxLength,
    this.fillColor,
    this.autofocus,
    this.textCapitalization,
    this.textColor,
    this.textStyle,
    this.verticalPadding = Sizes.PADDING_6,
    this.width,
    this.enableBorderColor,
    this.focusBorderColor,
    this.errorBorderColor,
    this.cursorColor,
    this.errorColor,
    this.onTap,
    this.height = Sizes.HEIGHT_8,
    this.borderRadius,
    this.onTapSelectAll = false,
    this.errorFontSize,
    this.inputDecoration,
    this.disableBorderColor,
    this.enabled,
    this.showValidator = true,
    this.customBorderRadius,
    this.textAlign = TextAlign.left,
  })  : assert(
          initialValue == null || controller == null,
          'Use either initialValue or controller.',
        ),
        assert(
          labelStyle == null || labelColor == null,
          'Cannot provide both a labelStyle and a labelColor\n'
          'To provide custom, use "labelStyle: TextStyle()".',
        ),
        assert(
          textStyle == null || textColor == null,
          'Cannot provide both a textStyle and a textColor\n'
          'To provide custom, use "textStyle: TextStyle()".',
        ),
        assert(
          prefixWidget == null || prefixIcon == null,
          'Cannot provide both a prefixWidget and a prefixIconData\n'
          'To provide custom, use "prefixWidget".',
        ),
        assert(
          prefixWidget == null || prefixIconColor == null,
          'Cannot provide both a prefixWidget and a prefixIconColor\n'
          'To provide custom, use "prefixWidget".',
        ),
        assert(
          suffixWidget == null || suffixIcon == null,
          'Cannot provide both a suffixWidget and a suffixIconData\n'
          'To provide custom, use "suffixWidget".',
        ),
        assert(
          suffixWidget == null || suffixIconColor == null,
          'Cannot provide both a suffixWidget and a suffixIconColor\n'
          'To provide custom, use "suffixWidget".',
        ),
        assert(
          !onTapSelectAll || onTap == null,
          'Cannot provide onTap when onTapSelectAll is true.',
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: FormBuilderTextField(
          textAlign: textAlign,
          name: validationKey ?? labelText ?? '',
          controller: controller,
          cursorColor: cursorColor ?? AppColors.primary,
          cursorRadius: const Radius.circular(Sizes.RADIUS_32),
          cursorWidth: Sizes.WIDTH_2,
          decoration: inputDecoration ?? buildInputDecoration(context),
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          autofocus: autofocus ?? false,
          focusNode: focusNode,
          readOnly: _readOnly,
          // Necessary to Avoid Text Field break Focus on TextInputAction.next
          enabled: enabled ?? !_readOnly,
          initialValue: initialValue,
          onTap: onTap ??
              (onTapSelectAll
                  ? () {
                      controller?.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: controller?.text.length ?? 0,
                      );
                    }
                  : null),
          onSubmitted: onFieldSubmit,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          buildCounter: (
            _, {
            required currentLength,
            maxLength,
            required isFocused,
          }) =>
              null,
          scrollPadding: const EdgeInsets.all(Sizes.PADDING_8),
          textCapitalization: textCapitalization ?? TextCapitalization.words,
          onEditingComplete: onEditingComplete,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          autovalidateMode: AutovalidateMode.disabled,
          enableSuggestions: true,
          onSaved: onSave,
          validator: (value) {
            if (isRequired && showValidator) {
              if (value?.trim().isEmpty ?? true) {
                return '${(requiredErrorMessage ?? labelText)} is required.';
              }

              if (validator != null) return validator!(value?.trim());
            } else {
              if ((value?.trim().isNotEmpty ?? false) && showValidator) {
                if (validator != null) return validator!(value?.trim());
              } else if (!showValidator) {
                return validator?.call(value?.trim());
              }
            }

            return null;
          },
          autofillHints: autofillHints,
          keyboardType: keyboardType ?? TextInputType.text,
          onChanged: onChanged,
          obscureText: obscureText ?? false,
          style: textStyle ??
              Get.context!.textTheme.titleMedium!.copyWith(
                color: textColor ?? AppColors.black,
                fontWeight: FontWeight.w400,
              ),
          obscuringCharacter: obscuringCharacter,
        ),
      ),
    );
  }

  bool get _readOnly => readOnly ?? false;

  InputDecoration buildInputDecoration(BuildContext context) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(
        left: Sizes.PADDING_8,
        right: Sizes.PADDING_2,
        top: height,
        bottom: height,
      ),
      floatingLabelBehavior: floatingLabelBehavior,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      label: RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          style: labelStyle ??
              Get.context!.bodyLarge.copyWith(
                color: labelColor ??
                    (_readOnly ? AppColors.black : AppColors.label),
                fontWeight: FontWeight.w400,
              ),
          children: [
            TextSpan(text: labelText),
            if (isRequired) ...[
              if (requiredLabelCharacter != '')
                const WidgetSpan(child: SpaceW4()),
              TextSpan(
                text: requiredLabelCharacter,
                style: Get.context!.textTheme.titleLarge!.copyWith(
                  color: requiredLabelColor ?? const Color(0xFFF1291A),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
      hintText: hintText,
      hintStyle: hintStyle,
      prefixIconConstraints: prefixIconConstraints,
      prefixIcon: prefixWidget ??
          (prefixIcon != null
              ? Icon(
                  prefixIcon,
                  size: prefixIconSize ?? Sizes.ICON_SIZE_22,
                  color: prefixIconColor ?? AppColors.enableBorder,
                )
              : null),
      suffixIcon: suffixIcon != null
          ? GestureDetector(
              onTap: onSuffixTap,
              child: Icon(
                suffixIcon,
                size: suffixIconSize ?? Sizes.ICON_SIZE_22,
                color: suffixIconColor ?? AppColors.enableBorder,
              ),
            ).mouseRegion
          : suffixWidget,
      enabledBorder: borderRadius != null || customBorderRadius != null
          ? OutlineInputBorder(
              borderRadius: customBorderRadius ??
                  BorderRadius.circular(borderRadius ?? Sizes.RADIUS_4),
              borderSide: BorderSide(
                color: enableBorderColor ??
                    Get.context!.enabledBorder.borderSide.color,
                width: Get.context!.enabledBorder.borderSide.width,
              ),
            )
          : Get.context!.enabledBorder.copyWith(
              borderSide: BorderSide(
                color: enableBorderColor ??
                    Get.context!.enabledBorder.borderSide.color,
                width: Get.context!.enabledBorder.borderSide.width,
              ),
            ),
      focusedBorder: borderRadius != null || customBorderRadius != null
          ? OutlineInputBorder(
              borderRadius: customBorderRadius ??
                  BorderRadius.circular(borderRadius ?? Sizes.RADIUS_4),
              borderSide: BorderSide(
                color: _readOnly
                    ? enableBorderColor ?? AppColors.enableBorder
                    : focusBorderColor ??
                        Get.context!.focusedBorder.borderSide.color,
                width: Get.context!.focusedBorder.borderSide.width,
              ),
            )
          : Get.context!.focusedBorder.copyWith(
              borderSide: BorderSide(
                color: _readOnly
                    ? enableBorderColor ?? AppColors.enableBorder
                    : focusBorderColor ??
                        Get.context!.focusedBorder.borderSide.color,
                width: Get.context!.focusedBorder.borderSide.width,
              ),
            ),
      errorBorder: borderRadius != null || customBorderRadius != null
          ? OutlineInputBorder(
              borderRadius: customBorderRadius ??
                  BorderRadius.circular(borderRadius ?? Sizes.RADIUS_4),
              borderSide: BorderSide(
                color: errorBorderColor ??
                    Get.context!.errorBorder.borderSide.color,
                width: Get.context!.errorBorder.borderSide.width,
              ),
            )
          : Get.context!.errorBorder.copyWith(
              borderSide: BorderSide(
                color: errorBorderColor ??
                    Get.context!.errorBorder.borderSide.color,
                width: Get.context!.errorBorder.borderSide.width,
              ),
            ),
      focusedErrorBorder: borderRadius != null
          ? OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(borderRadius ?? Sizes.RADIUS_4),
              borderSide: BorderSide(
                color: errorBorderColor ??
                    Get.context!.focusedErrorBorder.borderSide.color,
                width: Get.context!.focusedErrorBorder.borderSide.width,
              ),
            )
          : Get.context!.focusedErrorBorder.copyWith(
              borderSide: BorderSide(
                color: errorBorderColor ??
                    Get.context!.focusedErrorBorder.borderSide.color,
                width: Get.context!.focusedErrorBorder.borderSide.width,
              ),
            ),
      disabledBorder: borderRadius != null
          ? OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(borderRadius ?? Sizes.RADIUS_4),
              borderSide: BorderSide(
                color: disableBorderColor ??
                    Get.context!.disableBorder.borderSide.color,
                width: Get.context!.disableBorder.borderSide.width,
              ),
            )
          : Get.context!.disableBorder.copyWith(
              borderSide: BorderSide(
                color: disableBorderColor ??
                    Get.context!.disableBorder.borderSide.color,
                width: Get.context!.disableBorder.borderSide.width,
              ),
            ),
      fillColor: _readOnly && fillColor == null
          ? const Color(0xfff5f5f5)
          : fillColor ?? Get.context!.fillColor,
      filled: true,
      alignLabelWithHint: true,
      focusColor: Get.context!.primaryColor,
      errorStyle: Get.context!.bodySmall.copyWith(
        fontSize: errorFontSize,
        color: errorColor ?? Get.context!.errorColor,
      ),
      errorMaxLines: 2,
    );
  }
}
