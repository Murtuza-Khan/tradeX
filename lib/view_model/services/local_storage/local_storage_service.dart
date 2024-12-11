import '../../../resources/exports/index.dart';

enum CacheManagerKeys {
  token,
  sessionData,
  appLanguage,
  deviceToken,
  appIntroViewed
}

class LocalStorageService extends GetxService {
  Future<bool> saveIntroViewInfo(bool isViewed) async {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    await box.write(CacheManagerKeys.appIntroViewed.toString(), isViewed);
    return true;
  }

  bool? getIntroViewInfo() {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    return box.read(CacheManagerKeys.appIntroViewed.toString());
  }

  Future<void> removeIntroViewInfo() async {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    await box.remove(CacheManagerKeys.appIntroViewed.toString());
  }

  Future<bool> saveDeviceToken(String? token) async {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    await box.write(CacheManagerKeys.deviceToken.toString(), token ?? "");
    return true;
  }

  String? getDeviceToken() {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    return box.read(CacheManagerKeys.deviceToken.toString());
  }

  Future<bool> saveDefaultLanguage(String? language) async {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    await box.write(CacheManagerKeys.appLanguage.toString(), language ?? "en");
    return true;
  }

  String? getDefaultLanguage() {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    return box.read(CacheManagerKeys.appLanguage.toString());
  }

  Future<bool> saveToken(String? token) async {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    await box.write(CacheManagerKeys.token.toString(), token);
    return true;
  }

  Future<bool> saveSession(Session? session) async {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    await box.write(CacheManagerKeys.sessionData.toString(), session?.toJson());
    if (Platform.isAndroid) {
      log.f(session);
      log.e("SAVING SESSION : ${session?.toJson()}");
    } else {
      MacLog.printM(session);
      MacLog.printG("SAVING SESSION : ${session?.toJson()}");
    }
    return true;
  }

  String? getToken() {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    return box.read(CacheManagerKeys.token.toString());
  }

  Session? getSessionData() {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    if (Platform.isAndroid) {
      log.w("RESTORE SESSION : ${Session.fromJson(
        box.read(CacheManagerKeys.sessionData.toString()),
      ).toJson()}");
    } else {
      MacLog.printG(("RESTORE SESSION : ${Session.fromJson(
        box.read(CacheManagerKeys.sessionData.toString()),
      ).toJson()}"));
    }
    return Session.fromJson(box.read(CacheManagerKeys.sessionData.toString()));
  }

  Future<void> removeToken() async {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    await box.remove(CacheManagerKeys.token.toString());
    await box.remove(CacheManagerKeys.sessionData.toString());
  }
}
