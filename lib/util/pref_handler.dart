
import 'package:shared_preferences/shared_preferences.dart';

class PrefHandler {

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> savePref(String key, String value) async {
    await init();

    _prefs?.setString(key, value);
    print('added $key : $value');
  }

  static Future<String?> getPref(String key) async {

    await init();

    if(_prefs!.containsKey(key)) {
      return _prefs?.getString(key);
    }

    return null;
  }
}