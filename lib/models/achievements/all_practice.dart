import 'package:startup/models/practice/storage.dart';

import '../practice/status.dart';
import 'achievement.dart';

class AchievementAllPractice extends Achievement {
  static final AchievementAllPractice _singleton =
      AchievementAllPractice._internal();

  factory AchievementAllPractice() {
    return _singleton;
  }

  AchievementAllPractice._internal();

  @override
  Future<bool> get isCompleted async {
    return false;
    // await PracticeStorage.instance.update();
    // for (var i = 0; i < PracticeStorage.instance.size; i++) {
    //   var practice = PracticeStorage.instance.get(i);
    //   if (practice != null &&
    //       !(practice.status == PracticeStatus.unvisited ||
    //           practice.status == PracticeStatus.uncompleted)) {
    //     return false;
    //   }
    // }
    // return true;
  }

  @override
  String label = 'Пройти все практики курса';

  @override
  set isCompleted(Future<bool> _) {
    throw UnimplementedError();
  }
}
