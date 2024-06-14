import 'package:startup/models/practice/practice.dart';

class PracticeStorage {
  PracticeStorage._internal();
  static List<Practice> _storage = [];

  static final PracticeStorage _instance = PracticeStorage._internal();

  static PracticeStorage get instance => _instance;

  static Practice? get(int index) {
    if (index >= _storage.length || index <= 0) return null;
    return _storage[index - 1];
  }

  static List<Practice?> getPractices() {
    List<Practice?> result = [];
    for (int i = 0; i < size; i++) {
      result.add(PracticeStorage.get(i + 1));
    }
    return result;
  }

  static int get size {
    return 100;
  }
}
