import '../../../firebase_options.dart';
import '../../../resources/exports/index.dart';

class InitializationService {
  static DateTime? currentBackPressTime;
  static Future init() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    CustomLogger.configure();
    log.i(Flavor.environment);
    await dotenv.load(fileName: ".env");

    LicenseRegistry.addLicense(() async* {
      final license =
          await rootBundle.loadString('assets/fonts/Poppins/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });

    await GetStorage.init(Strings.CACHE_BOX_KEY);

    await GetStorage.init().then(
      (value) async {
        await Get.putAsync(() async => AuthManager(), permanent: true);
        await Get.putAsync(
          () async => ConnectivityStreamService(),
          permanent: true,
        );
      },
    );

// Firebase Notification Initialization
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseApi().initNotification();
    FirebaseMessaging.instance.subscribeToTopic("gk_tradex");

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    FlutterNativeSplash.remove();
  }

  static bool onWillPop(BuildContext context) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.only(bottom: 8.0, left: 12.0, right: 12.0),
          backgroundColor: AppColors.primary,
          elevation: 5.0,
          content: Center(
            child: Text(
              Strings.CLOSE_APPLICATION,
              style: context.titleMedium.copyWith(color: AppColors.white),
            ),
          ),
        ),
      );
      return false;
    } else {
      SystemNavigator.pop();
      return true;
    }
  }
}
