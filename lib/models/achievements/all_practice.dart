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
    // TODO: implement isCompleted
  }

  @override
  String label = 'Пройти все практики курса';

  @override
  set isCompleted(Future<bool> _isCompleted) {
    throw UnimplementedError();
  }
}
