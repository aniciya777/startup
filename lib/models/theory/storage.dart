import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:startup/models/practice/practice.dart';
import 'package:startup/models/theory/theory.dart';

class TheoryStorage {
  static final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  static final List<Theory> _storage = [];

  static final TheoryStorage _instance = TheoryStorage._internal();

  static late Future<DataSnapshot> _get;

  static TheoryStorage get instance => _instance;

  TheoryStorage._internal() {
    _update();
  }

  _update() {
    _storage.clear();
    _get = _ref.child('theory').get();
    _get.then((DataSnapshot snapshot) {
      for (var element in (snapshot.value as List<dynamic>)) {
        try {
          _storage.add(Theory(element['id'], element['name'], element['text']));
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
    });
  }

  Stream<DataSnapshot> stream() {
    return _get.asStream();
  }

  Theory? get(int index) {
    if (index > _storage.length || index < 0) return null;
    return _storage[index];
  }

  List<Theory?> getPractices() {
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
