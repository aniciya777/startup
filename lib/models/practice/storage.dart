import 'package:flutter/foundation.dart';
import 'package:startup/models/practice/practice.dart';

import '../../shared/base.dart';

class PracticeStorage {
  static final List<Practice> _storage = [];
  static final Map<int, int> _idMap = {};

  static final PracticeStorage _instance = PracticeStorage._internal();

  static late Future<Object?> _get;

  factory PracticeStorage() => _instance;

  PracticeStorage._internal() {
    update();
  }

  update() {
    _storage.clear();
    _idMap.clear();
    _get = Base.get('practice');
    _get.then((Object? data) {
      for (var element in (data as List<dynamic>)) {
        try {
          var practice = Practice.fromJson(element);
          _storage.add(practice);
          _idMap[practice.id] = _storage.length - 1;
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
    });
  }




  Stream<Object?> stream() {
    return _get.asStream();
  }

  Practice? get(int index) {
    if (index >= _storage.length || index < 0) return null;
    return _storage[index];
  }

  Practice? getById(int id) {
    if (!_idMap.containsKey(id)) {
      return null;
    }
    return _storage[_idMap[id]!];
  }

  List<Practice?> getPractices() {
    List<Practice?> result = [];
    for (int i = 0; i < size; i++) {
      result.add(get(i));
    }
    return result;
  }

  static int get size {
    return 10;
  }
}
