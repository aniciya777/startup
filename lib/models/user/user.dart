import 'package:firebase_auth/firebase_auth.dart';
import 'package:startup/models/tests/user_mixin.dart';
import 'package:startup/models/theory/user_mixin.dart';
import 'package:startup/models/user/easter_egg.dart';

class UserProfile with TheoryUserMixin, TestUserMixin {
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
    await TheoryUserMixin.updateVisitedTheory();
    await TestUserMixin.updateTests();
  }

  static save() async {

  }

  static String get id => _user?.uid ?? '';
}
