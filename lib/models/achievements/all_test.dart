import 'package:startup/models/tests/test_status.dart';

import '../theory/storage.dart';
import 'achievement.dart';

class AchievementAllTest extends Achievement {
  static final AchievementAllTest _singleton =
  AchievementAllTest._internal();

  factory AchievementAllTest() {
    return _singleton;
  }

  AchievementAllTest._internal();

  @override
  Future<bool> get isCompleted async {
    return false;
    // await TheoryStorage.instance.update();
    // for (var i = 0; i < TheoryStorage.instance.size; i++) {
    //   var status = TheoryStorage.instance.get(i)?.status ?? TestStatus.none;
    //   if (status == TestStatus.unvisited || status == TestStatus.uncompleted) {
    //     return false;
    //   }
    // }
    // return true;
  }

  @override
  String label = 'Пройти все тесты к теории курса';

  @override
  set isCompleted(Future<bool> _) {
    throw UnimplementedError();
  }
}
