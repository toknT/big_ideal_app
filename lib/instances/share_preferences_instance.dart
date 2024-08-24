import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesInstance {
  static late final SharedPreferences _prefs;
  SharedPreferences get prefs => _prefs;
  static initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  factory SharedPreferencesInstance() => _instance;
  static final SharedPreferencesInstance _instance =
      SharedPreferencesInstance._internal();
  SharedPreferencesInstance._internal();
}
