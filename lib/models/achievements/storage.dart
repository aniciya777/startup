import 'package:startup/models/achievements/all_practice.dart';
import 'package:startup/models/achievements/all_test.dart';
import 'package:startup/models/achievements/all_theory.dart';

import 'achievement.dart';

class AchievementStorage {
  static final AchievementStorage _singleton = AchievementStorage._internal();

  factory AchievementStorage() {
    return _singleton;
  }

  AchievementStorage._internal();

  static final List<Achievement?> _achievements = [
    AchievementAllTheory(),
    AchievementAllPractice(),
    AchievementAllTest(),
    null,
    null,
    null,
  ];

  static Achievement? get(int index) {
    return _achievements[index];
  }

  static const size = 6;
}
