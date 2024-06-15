import 'package:firebase_database/firebase_database.dart';
import 'package:startup/models/practice/practice.dart';

class PracticeStorage {
  static final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  static final List<Practice> _storage = [];

  static final PracticeStorage _instance = PracticeStorage._internal();

  factory PracticeStorage() => _instance;

  PracticeStorage._internal() {
    // TODO
  }

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
    return 10;
  }
}
