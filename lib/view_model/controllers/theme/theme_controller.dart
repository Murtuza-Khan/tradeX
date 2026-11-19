import '../../../resources/exports/index.dart' hide ThemeData;
import 'package:material_ui/material_ui.dart' as material_ui;

class ThemeController {
  Color accentColor = AppColors.primary;

  material_ui.ThemeData get getTheme => AppTheme.build(
        isDarkMode: false,
        brightness: Brightness.light,
        swatchColors: material_ui.MaterialColor(
          accentColor.getColorHex,
          AppTheme.getSwatch(accentColor),
        ),
        primaryColor: accentColor,
      );
}
