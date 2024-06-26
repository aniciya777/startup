import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:startup/models/practice/practice.dart';
import 'package:startup/models/practice/user_mixin.dart';

import '../../shared/base.dart';

class PracticeStorage {
  static final List<Practice> _storage = [];
  static final Map<int, int> _idMap = {};

  static final PracticeStorage instance = PracticeStorage._internal();

  static final StreamController<Object?> _streamController = StreamController<Object?>.broadcast();

  factory PracticeStorage() => instance;

  PracticeStorage._internal() {
    update();
  }

  update() async {
    _storage.clear();
    _idMap.clear();
    Object? data = await Base.get('practice');
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
    await PracticeUserMixin.updatePractices();
    notifyListeners();
  }

  static notifyListeners() {
    _streamController.sink.add(null);
  }

  Stream<Object?> stream() {
    return _streamController.stream;
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

  int get size {
    return 30;
  }
}
