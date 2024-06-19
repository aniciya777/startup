import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:startup/models/theory/storage.dart';

class UserProfile {
  static final _obj = FirebaseAuth.instance;
  static final UserProfile _instance = UserProfile._internal();
  static final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  static User? _user;
  static Set<int> _visitedTheory = {};

  factory UserProfile() => _instance;

  UserProfile._internal() {
    _obj.authStateChanges().listen((User? user) async {
      if (user != null) {
        _user = user;
        await update();
      }
    });
  }

  static update() async {
    _user = _obj.currentUser;
    await updateVisitedTheory();
  }

  static updateVisitedTheory() async {
    _visitedTheory.clear();
    final snapshot = await _ref.child('theory_visited/${UserProfile.id}').get();
    if (snapshot.exists) {
      try {
        for (var theoryId in (snapshot.value as List)) {
          _visitedTheory.add(theoryId);
          TheoryStorage.instance.getById(theoryId)?.visited = true;
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }

  static save() async {

  }

  static visitTheory(int theoryId) async {
    if (_visitedTheory.contains(id)) {
      return;
    }
    _visitedTheory.add(theoryId);
    TheoryStorage.instance.getById(theoryId)?.visited = true;
    DatabaseReference ref = FirebaseDatabase.instance.ref('theory_visited/${UserProfile.id}');
    await ref.set(_visitedTheory.toList()..sort());
  }

  static String get id => _user?.uid ?? '';
  static int get countVisitedTheory => _visitedTheory.length;
}
