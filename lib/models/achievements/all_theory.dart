import '../theory/storage.dart';
import 'achievement.dart';

class AchievementAllTheory extends Achievement {
  static final AchievementAllTheory _singleton =
      AchievementAllTheory._internal();

  factory AchievementAllTheory() {
    return _singleton;
  }

  AchievementAllTheory._internal();

  @override
  Future<bool> get isCompleted async {
    return false;
    // await TheoryStorage.instance.update();
    // for (var i = 0; i < TheoryStorage.instance.size; i++) {
    //   if (!(TheoryStorage.instance.get(i)?.visited ?? false)) {
    //     return false;
    //   }
    // }
    // return true;
  }

  @override
  String label = 'Прочитать все темы курса';

  @override
  set isCompleted(Future<bool> _) {
    throw UnimplementedError();
  }
}
