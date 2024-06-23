import 'package:shared_preferences/shared_preferences.dart';

class EasterEgg {
  static SharedPreferences? _prefs;

  EasterEgg() {
    SharedPreferences.getInstance().then((value) {
      _prefs = value;
    });
  }

  static int get countTaps {
    if (_prefs == null) {
      return 0;
    }
    return _prefs?.getInt('countTaps') ?? 0;
  }

  static void incrementCountTaps() {
    _prefs?.setInt('countTaps', countTaps + 1);
  }
}