import '../../../resources/exports/index.dart';

class AuthManager extends LocalStorageService implements GetxService {
  static AuthManager instance = Get.find();

  late Rx<Session?> session = Rxn<Session>();

  final RxBool _isLoggedIn = false.obs;

  Rx<bool> rememberCredentials = false.obs;

  bool get isLoggedIn => _isLoggedIn.value;

  String get token => session.value?.token ?? '';

  UserModel get user => session.value?.user ?? UserModel();
  set user(UserModel? user) => session.value?.user = user;

  CompaniesModel get company => session.value?.company ?? CompaniesModel();
  set company(CompaniesModel? company) => session.value?.company = company;

  String get defaultLanguage => getDefaultLanguage() ?? "en";

  String get deviceToken => getDeviceToken() ?? "";

  Future<void> login(Session? session) async {
    _isLoggedIn.value = true;
    if (rememberCredentials.value) await saveToken(session?.token);
    await saveCurrentSession(session: session);
  }

  Future<bool> checkLoginStatus() async {
    try {
      final token = getToken();

      if (token != null) {
        rememberCredentials.value = true;

        _isLoggedIn.value = true;

        session.value = getSessionData();

        return _isLoggedIn.value;
      } else {
        session.value = Session();
      }
      return false;
    } catch (e) {
      removeToken();
    }
    return false;
  }

  Future<bool> saveAndUpdateSession({
    UserModel? user,
    CompaniesModel? company,
  }) async {
    Session? savedSession = getSessionData();
    if (savedSession == null) return false;
    if (user == null && company == null) {
      CustomSnackBar.errorSnackBar(message: Strings.PROVIDED_DATA);
      return false;
    }

    if (user != null) this.user = user;
    if (company != null) this.company = company;

    Session? session = this.session.value?.copyWith(
          user: this.user,
          company: this.company,
        );
    bool saved = await saveSession(session);
    if (!saved) return false;

    this.session.value = session;
    return true;
  }

  Future<void> saveCurrentSession({
    Object? id,
    UserModel? user,
    CompaniesModel? company,
    Session? session,
  }) async {
    if (session != null) this.session.value = session;
    this.session.update((session) {
      if (user != null) session!.user = user;
      if (company != null) session!.company = company;
    });
    if (rememberCredentials.value) await saveSession(this.session.value);
  }

  Future<void> logout() async {
    final token = getToken();
    if (token != null) removeToken();

    session = Session().obs;
    _isLoggedIn.value = false;
    rememberCredentials.value = true;
    log.t(session.toJson());
  }
}
