import 'package:flutter/foundation.dart';
import 'package:startup/models/theory/storage.dart';
import 'package:startup/shared/base.dart';

import '../user/user.dart';

mixin TheoryUserMixin {
  static final Set<int> _visitedTheory = {};

  static visitTheory(int theoryId) async {
    if (_visitedTheory.contains(theoryId)) {
      return;
    }
    var theory = TheoryStorage.instance.getById(theoryId);
    if (theory == null) {
      return;
    }
    theory.visited = true;
    _visitedTheory.add(theoryId);
    await Base.set('theory_visited/${UserProfile.id}', _visitedTheory.toList()..sort());
  }

  static updateVisitedTheory() async {
    _visitedTheory.clear();
    final value = await Base.get('theory_visited/${UserProfile.id}');

    if (value != null) {
      try {
        for (var theoryId in (value as List)) {
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
}