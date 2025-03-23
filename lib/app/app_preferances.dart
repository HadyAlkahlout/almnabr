import 'package:shared_preferences/shared_preferences.dart';
import 'package:teqani/presentation/resources/local_manager.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_TOKEN = "PREFS_KEY_TOKEN";
const String PREFS_KEY_NAME = "PREFS_KEY_NAME";
const String PREFS_KEY_EMAIL = "PREFS_KEY_EMAIL";
const String PREFS_KEY_MOBILE = "PREFS_KEY_MOBILE";

class AppPreferences {
  static SharedPreferences? _sharedPreferences;

  static Future<SharedPreferences> init() async {
    return _sharedPreferences = await SharedPreferences.getInstance();
  }

  static String getAppLanguage() {
    String? language = _sharedPreferences?.getString(PREFS_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  static void setLanguageChanged() {
    String currentLanguage = getAppLanguage();
    if (currentLanguage == LanguageType.ARABIC.getValue()) {
      // save prefs with english lang
      _sharedPreferences?.setString(
          PREFS_KEY_LANG, LanguageType.ENGLISH.getValue());
    } else {
      // save prefs with arabic lang
      _sharedPreferences?.setString(
          PREFS_KEY_LANG, LanguageType.ARABIC.getValue());
    }
  }

  static void setUserToken(String token) {
    _sharedPreferences?.setString(PREFS_KEY_TOKEN, token);
  }

  static String getUserToken() {
    return _sharedPreferences?.getString(PREFS_KEY_TOKEN) ?? "";
  }

  static void setUserData(String name,String email,String mobile) {
    _sharedPreferences?.setString(PREFS_KEY_NAME, name);
    _sharedPreferences?.setString(PREFS_KEY_EMAIL, email);
    _sharedPreferences?.setString(PREFS_KEY_MOBILE, mobile);
  }

  static String getUserName() {
    return _sharedPreferences?.getString(PREFS_KEY_NAME) ?? "";
  }

  static String getUserEmail() {
    return _sharedPreferences?.getString(PREFS_KEY_EMAIL) ?? "";
  }

  static String getUserMobile() {
    return _sharedPreferences?.getString(PREFS_KEY_MOBILE) ?? "";
  }

  static void setIsUserLoggedIn() {
    _sharedPreferences?.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  static bool isUserLoggedIn() {
    return _sharedPreferences?.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  static void logout() {
    _sharedPreferences?.remove(PREFS_KEY_IS_USER_LOGGED_IN);
    _sharedPreferences?.remove(PREFS_KEY_TOKEN);
    _sharedPreferences?.remove(PREFS_KEY_NAME);
    _sharedPreferences?.remove(PREFS_KEY_EMAIL);
    _sharedPreferences?.remove(PREFS_KEY_MOBILE);
  }
}