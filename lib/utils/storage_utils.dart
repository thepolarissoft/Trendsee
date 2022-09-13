import 'package:get_storage/get_storage.dart';

class StorageUtils {
  static final String keyLatitude = "key_latitude";
  static final String keyLongitude = "key_longitude";
  static final String keyToken = 'token';
  static final String keyUserType = 'user_type';
  static final String keyBusinessType = 'business_type';

  static GetStorage getStorage = GetStorage();
  static Future<GetStorage> get _instance async => getStorage;

  static Future<GetStorage> init() async {
    getStorage = await _instance;
    return getStorage;
  }

  static writeStringValue(String key, String? value) {
    return getStorage.write(key, value);
  }

  static String readStringValue(String key) {
    return getStorage.read(key) ?? "";
  }

  static writeDoubleValue(String key, double value) {
    return getStorage.write(key, value) ;
  }

  static double readDoubleValue(String key) {
    return getStorage.read(key) ?? 0;
  }

  static writeIntValue(String key, int? value) {
    return getStorage.write(key, value) ;
  }

  static int readIntValue(String key) {
    return getStorage.read(key) ?? 0;
  }

  static void removeKey(String key) async {
    await getStorage.remove(key);
  }

  static void eraseStorage() async {
    await getStorage.erase();
  }
}
