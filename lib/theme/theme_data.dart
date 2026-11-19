import '../resources/exports/index.dart' hide ThemeData;
import 'package:material_ui/material_ui.dart' as material_ui;

material_ui.AppBarTheme appBarTheme({
  required Color primaryColor,
  required Color appBarColor,
}) =>
    material_ui.AppBarTheme(
      backgroundColor: appBarColor,
      elevation: 0,
      iconTheme: IconThemeData(color: primaryColor),
      titleTextStyle: TextStyle(
        fontSize: Sizes.TEXT_SIZE_16,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
    );

material_ui.ScrollbarThemeData scrollbarTheme({
  required Color primaryColor,
}) =>
    material_ui.ScrollbarThemeData(
      trackColor: WidgetStateProperty.all(primaryColor),
    );

material_ui.DataTableThemeData dataTableTheme({
  required Color primaryColor,
  required Color textColor,
}) =>
    material_ui.DataTableThemeData(
      columnSpacing: 24,
      headingRowColor: WidgetStateProperty.all(primaryColor),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.RADIUS_20)),
        border: Border.all(color: primaryColor),
      ),
      dataTextStyle: TextStyle(
        fontSize: Sizes.TEXT_SIZE_12,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
