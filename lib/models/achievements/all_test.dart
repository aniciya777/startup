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
    // TODO: implement isCompleted
  }

  @override
  String label = 'Пройти все тесты к теории курса';

  @override
  set isCompleted(Future<bool> _isCompleted) {
    throw UnimplementedError();
  }
}
