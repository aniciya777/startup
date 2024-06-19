import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:startup/models/theory/theory.dart';
import 'package:startup/models/user/user.dart';

class TheoryStorage {
  static final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  static final List<Theory> _storage = [];
  static final Map<int, int> _idMap = {};

  static final TheoryStorage _instance = TheoryStorage._internal();

  static late Future<DataSnapshot> _get;

  static TheoryStorage get instance => _instance;

  TheoryStorage._internal() {
    update();
  }

  update() {
    _storage.clear();
    _idMap.clear();
    _get = _ref.child('theory').get();
    _get.then((DataSnapshot snapshot) {
      for (var element in (snapshot.value as List<dynamic>)) {
        try {
          var theory = Theory(element['id'], element['name'], element['text']);
          _storage.add(theory);
          _idMap[theory.id] = _storage.length - 1;
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
    });
    UserProfile.updateVisitedTheory().then((_) {});
  }

  Stream<DataSnapshot> stream() {
    return _get.asStream();
  }

  Theory? get(int index) {
    if (index > _storage.length || index < 0) return null;
    return _storage[index];
  }

  Theory? getById(int id) {
    if (!_idMap.containsKey(id)) {
      return null;
    }
    return _storage[_idMap[id]!];
  }

  List<Theory?> getTheory() {
    List<Theory?> result = [];
    for (int i = 0; i < size; i++) {
      result.add(get(i + 1));
    }
    return result;
  }

  int get size {
    return _storage.length;
  }
}
