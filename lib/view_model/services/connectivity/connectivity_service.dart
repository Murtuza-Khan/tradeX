import '../../../resources/exports/index.dart';

class ConnectivityStreamService extends GetxService {
  AuthManager get authManager => AuthManager.instance;

  Future<bool> initializeAuthentication() async {
    return authManager.checkLoginStatus();
  }

  late RxBool isConnected = false.obs;
  late StreamSubscription<List<ConnectivityResult>> _streamSubscription;

  @override
  void onInit() async {
    super.onInit();
    initializeAuthentication();
    initializeConnectivity();
    checkConnectivityStream();
  }

  void checkConnectivityStream() async {
    _streamSubscription = Connectivity().onConnectivityChanged.listen(
      (status) async {
        if (status.contains(ConnectivityResult.ethernet) ||
            status.contains(ConnectivityResult.mobile) ||
            status.contains(ConnectivityResult.wifi)) {
          if (!isConnected.value) {
            if (!authManager.isLoggedIn) await authManager.checkLoginStatus();
            isConnected.value = true;
            if (WidgetsFlutterBinding.ensureInitialized()
                .firstFrameRasterized) {
              Get.back();
            }
          }
        } else {
          isConnected.value = false;
          if (WidgetsFlutterBinding.ensureInitialized().firstFrameRasterized) {
            Get.toNamed(Routes.OFFLINE);
          }
        }
      },
    );
  }

  Future<void> initializeConnectivity() async {
    List<ConnectivityResult> connectionStatus =
        await Connectivity().checkConnectivity();

    switch (connectionStatus) {
      case [ConnectivityResult.ethernet]:
      case [ConnectivityResult.mobile]:
      case [ConnectivityResult.wifi]:
        isConnected = true.obs;
        break;
      default:
        isConnected = false.obs;
        break;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
    super.onClose();
  }
}
