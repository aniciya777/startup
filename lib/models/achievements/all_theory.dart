import '../theory/storage.dart';
import '../user/user.dart';
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
    await TheoryStorage.instance.update();
    return UserProfile.countVisitedTheory == TheoryStorage.instance.size;
  }

  @override
  String label = 'Прочитать все темы курса';

  @override
  set isCompleted(Future<bool> _isCompleted) {
    throw UnimplementedError();
  }
}
