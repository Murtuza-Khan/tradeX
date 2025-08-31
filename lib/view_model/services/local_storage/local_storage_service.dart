import '../../../resources/exports/index.dart';

enum CacheManagerKeys {
  deltaToken,
  deltaSessionData,
  deltaAppLanguage,
  deltaDeviceToken,
  deltaAppIntroViewed
}

class LocalStorageService extends GetxService {
  Future<bool> saveIntroViewInfo(bool isViewed) async {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    await box.write(CacheManagerKeys.deltaAppIntroViewed.toString(), isViewed);
    return true;
  }

  bool? getIntroViewInfo() {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    return box.read(CacheManagerKeys.deltaAppIntroViewed.toString());
  }

  Future<void> removeIntroViewInfo() async {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    await box.remove(CacheManagerKeys.deltaAppIntroViewed.toString());
  }

  Future<bool> saveDeviceToken(String? token) async {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    await box.write(CacheManagerKeys.deltaDeviceToken.toString(), token ?? "");
    return true;
  }

  String? getDeviceToken() {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    return box.read(CacheManagerKeys.deltaDeviceToken.toString());
  }

  Future<bool> saveDefaultLanguage(String? language) async {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    await box.write(
        CacheManagerKeys.deltaAppLanguage.toString(), language ?? "en");
    return true;
  }

  String? getDefaultLanguage() {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    return box.read(CacheManagerKeys.deltaAppLanguage.toString());
  }

  Future<bool> saveToken(String? token) async {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    await box.write(CacheManagerKeys.deltaToken.toString(), token);
    return true;
  }

  Future<bool> saveSession(Session? session) async {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    await box.write(
        CacheManagerKeys.deltaSessionData.toString(), session?.toJson());
    if (Platform.isAndroid) {
      log.e("SAVING SESSION : ${session?.toJson()}");
    } else {
      MacLog.printG("SAVING SESSION : ${session?.toJson()}");
    }
    return true;
  }

  String? getToken() {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    return box.read(CacheManagerKeys.deltaToken.toString());
  }

  Session? getSessionData() {
    try {
      final box = GetStorage(Strings.CACHE_BOX_KEY);
      if (Platform.isAndroid) {
        log.w("RESTORE SESSION : ${Session.fromJson(
          box.read(CacheManagerKeys.deltaSessionData.toString()),
        ).toJson()}");
      } else {
        MacLog.printO(("RESTORE SESSION : ${Session.fromJson(
          box.read(CacheManagerKeys.deltaSessionData.toString()),
        ).toJson()}"));
      }
      return Session.fromJson(
          box.read(CacheManagerKeys.deltaSessionData.toString()));
    } catch (e) {
      MacLog.printR("Session is empty!");
      return null;
    }
  }

  Future<void> removeToken() async {
    final box = GetStorage(Strings.CACHE_BOX_KEY);
    await box.remove(CacheManagerKeys.deltaToken.toString());
    await box.remove(CacheManagerKeys.deltaSessionData.toString());
  }
}
