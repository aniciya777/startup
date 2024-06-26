import 'package:flutter/foundation.dart';
import 'package:startup/models/practice/status.dart';
import 'package:startup/models/practice/storage.dart';

import '../../shared/base.dart';
import '../user/user.dart';

mixin PracticeUserMixin {
  static final Set<int> _completedPractice = {};
  static final Set<int> _uncompletedPractice = {};

  static _saveCompletedPractice() async {
    await Base.set('practice_completed/${UserProfile.id}', _completedPractice.toList()..sort());
  }

  static _saveUncompletedPractice() async {
    await Base.set('practice_uncompleted/${UserProfile.id}', _uncompletedPractice.toList()..sort());
  }

  static uncompletePractice(int practiceId) async {
    if (_uncompletedPractice.contains(practiceId)) {
      return;
    }
    var practice = PracticeStorage.instance.getById(practiceId);
    if (practice == null) {
      return;
    }
    if (practice.status == PracticeStatus.completed) {
      return;
    }
    practice.status = PracticeStatus.uncompleted;
    _uncompletedPractice.add(practiceId);
    await _saveUncompletedPractice();
    PracticeStorage.notifyListeners();
  }

  static completePractice(int practiceId) async {
    if (_completedPractice.contains(practiceId)) {
      return;
    }
    var practice = PracticeStorage.instance.getById(practiceId);
    if (practice == null) {
      return;
    }
    if (practice.status == PracticeStatus.uncompleted) {
      _uncompletedPractice.remove(practiceId);
      await _saveUncompletedPractice();
    }
    practice.status = PracticeStatus.completed;
    _completedPractice.add(practiceId);
    await _saveCompletedPractice();
    PracticeStorage.notifyListeners();
  }

  static updatePractices() async {
    _uncompletedPractice.clear();
    var value = await Base.get('practice_uncompleted/${UserProfile.id}');
    if (value != null) {
      try {
        for (var practiceId in (value as List)) {
          _uncompletedPractice.add(practiceId);
          PracticeStorage.instance.getById(practiceId)?.status = PracticeStatus.uncompleted;
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    _completedPractice.clear();
    value = await Base.get('practice_completed/${UserProfile.id}');
    if (value != null) {
      try {
        for (var practiceId in (value as List)) {
          _completedPractice.add(practiceId);
          PracticeStorage.instance.getById(practiceId)?.status = PracticeStatus.completed;
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    PracticeStorage.notifyListeners();
  }
}