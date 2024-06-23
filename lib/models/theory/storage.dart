import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:startup/models/theory/theory.dart';
import 'package:startup/models/theory/user_mixin.dart';

import '../../shared/base.dart';
import '../tests/user_mixin.dart';

class TheoryStorage {
  static final List<Theory> _storage = [];
  static final Map<int, int> _idMap = {};

  static final TheoryStorage _instance = TheoryStorage._internal();

  static late Future<Object?> _get;

  static TheoryStorage get instance => _instance;

  TheoryStorage._internal() {
    update();
  }

  update() {
    _storage.clear();
    _idMap.clear();
    _get = Base.get('theory');
    _get.then((Object? data) {
      for (var element in (data as List<dynamic>)) {
        try {
          var theory = Theory.fromJson(element);
          _storage.add(theory);
          _idMap[theory.id] = _storage.length - 1;
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
      TheoryUserMixin.updateVisitedTheory().then((_) {});
      TestUserMixin.updateTests().then((_) {});
    });
  }

  Stream<Object?> stream() {
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
