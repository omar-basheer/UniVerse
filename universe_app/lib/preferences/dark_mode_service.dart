import 'package:shared_preferences/shared_preferences.dart';

class DarkModeService {
  static SharedPreferences? _sharedPreferences;

  static Future<void> initDarkPreference() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static bool getDarkMode() {
    return _sharedPreferences?.getBool('darkMode') ?? false;
  }

  static Future<void> setDarkMode(bool value) async {
    await _sharedPreferences?.setBool('darkMode', value);
  }
}
