import '../../resources/exports/index.dart';

class AppColorsModel {
  Color? primaryColor;
  Color? secondaryColor;
  Color? tertiaryColor;
  Color? backgroundColor;

  AppColorsModel({
    this.primaryColor,
    this.secondaryColor,
    this.tertiaryColor,
    this.backgroundColor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'primary_color': HexColor.colorToHex(primaryColor),
      'secondary_color': HexColor.colorToHex(secondaryColor),
      'tertiary_color': HexColor.colorToHex(tertiaryColor),
      'background_color': HexColor.colorToHex(backgroundColor),
    };
  }

  factory AppColorsModel.fromMap(Map<String, dynamic> map) {
    return AppColorsModel(
      primaryColor: map['primary_color'] != null
          ? HexColor.fromHex(map['primary_color'])
          : Color(0xFF2b4187),
      secondaryColor: map['secondary_color'] != null
          ? HexColor.fromHex(map['secondary_color'])
          : AppColors.black,
      tertiaryColor: map['tertiary_color'] != null
          ? HexColor.fromHex(map['tertiary_color'])
          : Colors.transparent,
      backgroundColor: map['background_color'] != null
          ? HexColor.fromHex(map['background_color'])
          : AppColors.white,
    );
  }

  @override
  String toString() {
    return 'AppColorsModel(primaryColor: $primaryColor, secondaryColor: $secondaryColor, tertiaryColor: $tertiaryColor, backgroundColor: $backgroundColor)';
  }

  bool isThemeChanged(AppColorsModel colors) {
    if (primaryColor != colors.primaryColor ||
        secondaryColor != colors.secondaryColor ||
        tertiaryColor != colors.tertiaryColor ||
        backgroundColor != colors.backgroundColor) {
      return true;
    } else {
      return false;
    }
  }
}
