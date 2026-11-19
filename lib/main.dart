import 'resources/exports/index.dart';
import 'package:flutter/material.dart' as flutter;
import 'package:material_ui/material_ui.dart' as mui;

Future<void> main() async {
  await InitializationService.init();
  (String, Map<String, dynamic>?) route = await getInitNotif();
  runApp(MyApp(route: route));
}
flutter.ThemeData convertTheme(mui.ThemeData theme) {
  return flutter.ThemeData(
    brightness: flutter.Brightness.light,
    primaryColor: theme.primaryColor,
  );
}
class MyApp extends StatelessWidget {
  final (String, Map<String, dynamic>?) route;
  const MyApp({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: AdaptiveTheme(
        light: ThemeController().getTheme,
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => GetMaterialApp(
          title: Strings.APP_NAME,
          debugShowCheckedModeBanner: false,
          theme: convertTheme(theme),
          builder: (context, widget) {
            return ResponsiveWrapper.builder(
              MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1),
                  boldText: false,
                  highContrast: false,
                  invertColors: false,
                ),
                child: BouncingScrollWrapperX.builder(
                  context,
                  widget!,
                  dragWithMouse: true,
                ),
              ),
              defaultScale: true,
              breakpoints: const [
                ResponsiveBreakpoint.autoScaleDown(450, name: MOBILE),
              ],
            );
          },
          onGenerateRoute: (settings) => Pages.onGenerateRoute(
            route.$2 != null
                ? RouteSettings(name: settings.name, arguments: route.$2)
                : settings,
          ),
          initialRoute: route.$1,
          defaultTransition: Transition.rightToLeft,
          smartManagement: SmartManagement.full,
        ),
      ),
    );
  }
}
