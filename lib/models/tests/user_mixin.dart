import 'package:flutter/foundation.dart';
import 'package:startup/models/tests/test_status.dart';

import '../../shared/base.dart';
import '../theory/storage.dart';
import '../user/user.dart';

mixin TestUserMixin {
  static final Set<int> _completedTests = {};
  static final Set<int> _uncompletedTests = {};

  static _saveCompletedTests() async {
    await Base.set('tests_completed/${UserProfile.id}', _completedTests.toList()..sort());
  }

  static _saveUncompletedTests() async {
    await Base.set('tests_uncompleted/${UserProfile.id}', _uncompletedTests.toList()..sort());
  }

  static uncompleteTest(int theoryId) async {
    if (_uncompletedTests.contains(theoryId)) {
      return;
    }
    var theory = TheoryStorage.instance.getById(theoryId);
    if (theory == null) {
      return;
    }
    if (theory.status == TestStatus.completed) {
      return;
    }
    theory.status = TestStatus.uncompleted;
    _uncompletedTests.add(theoryId);
    await _saveUncompletedTests();
  }

  static completeTest(int theoryId) async {
    if (_completedTests.contains(theoryId)) {
      return;
    }
    var theory = TheoryStorage.instance.getById(theoryId);
    if (theory == null) {
      return;
    }
    if (theory.status == TestStatus.uncompleted) {
      _uncompletedTests.remove(theoryId);
      await _saveUncompletedTests();
    }
    theory.status = TestStatus.completed;
    _completedTests.add(theoryId);
    await _saveCompletedTests();
  }

  static updateTests() async {
    _uncompletedTests.clear();
    var value = await Base.get('tests_uncompleted/${UserProfile.id}');
    if (value != null) {
      try {
        for (var theoryId in (value as List)) {
          _uncompletedTests.add(theoryId);
          TheoryStorage.instance.getById(theoryId)?.status = TestStatus.uncompleted;
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    _completedTests.clear();
    value = await Base.get('tests_completed/${UserProfile.id}');
    if (value != null) {
      try {
        for (var theoryId in (value as List)) {
          _completedTests.add(theoryId);
          TheoryStorage.instance.getById(theoryId)?.status = TestStatus.completed;
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
  }
}