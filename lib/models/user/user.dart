import 'package:firebase_auth/firebase_auth.dart';
import 'package:startup/models/practice/storage.dart';
import 'package:startup/models/practice/user_mixin.dart';
import 'package:startup/models/tests/user_mixin.dart';
import 'package:startup/models/theory/storage.dart';
import 'package:startup/models/theory/user_mixin.dart';

class UserProfile with TheoryUserMixin, TestUserMixin, PracticeUserMixin {
  static final _obj = FirebaseAuth.instance;

  static User? _user;

  static final UserProfile instance =
  UserProfile._internal();

  factory UserProfile() {
    return instance;
  }

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
    TheoryStorage.instance.update();
    await TheoryUserMixin.updateVisitedTheory();
    await TestUserMixin.updateTests();
  }

  static String get id => _user?.uid ?? '';
}
