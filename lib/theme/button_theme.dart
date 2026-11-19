import '../resources/exports/index.dart' hide ThemeData;
import 'package:material_ui/material_ui.dart' as material_ui;

material_ui.ButtonThemeData buttonTheme({
  required Color primaryColor,
}) =>
    const material_ui.ButtonThemeData(
      padding: EdgeInsets.all(Sizes.PADDING_20),
      colorScheme: material_ui.ColorScheme.light(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(Sizes.RADIUS_12)),
      ),
      height: Sizes.HEIGHT_32,
      minWidth: double.infinity,
    );

material_ui.ElevatedButtonThemeData elevatedButtonTheme({
  required Color primaryColor,
}) =>
    material_ui.ElevatedButtonThemeData(
      style: material_ui.ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(Sizes.PADDING_20),
        foregroundColor: primaryColor,
        minimumSize: const Size(double.infinity, Sizes.HEIGHT_32),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.RADIUS_12)),
        ),
      ),
    );

material_ui.TextButtonThemeData textButtonTheme({
  required Color primaryColor,
}) =>
    material_ui.TextButtonThemeData(
      style: material_ui.TextButton.styleFrom(foregroundColor: primaryColor),
    );

material_ui.OutlinedButtonThemeData outlinedButtonTheme({
  required Color primaryColor,
  required Color borderColor,
}) {
  return material_ui.OutlinedButtonThemeData(
    style: material_ui.OutlinedButton.styleFrom(
      padding: const EdgeInsets.all(Sizes.PADDING_20),
      foregroundColor: primaryColor,
      minimumSize: const Size(double.infinity, Sizes.HEIGHT_32),
      side: BorderSide(width: 1.5, color: borderColor),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.RADIUS_12),
        ),
      ),
    ),
  );
}
