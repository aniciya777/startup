import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup/shared/scheme_plan.dart';

class PlanStorage {
  static Future<String> get(int index) async {
    if (index < 0 || index >= SchemePlan.keys.length) {
      return '';
    }
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString(SchemePlan.keys[index]) ?? '';
  }

  static Future<void> set(int index, String value) async {
    if (index < 0 || index >= SchemePlan.keys.length) {
      return;
    }
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(SchemePlan.keys[index], value);
  }
}
