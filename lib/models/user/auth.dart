import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup/models/user/_exceptions.dart';
import 'package:startup/models/user/user.dart';

class Auth {
  static const int minPasswordLength = 8;
  static const String _emailKey = 'email';
  static const String _passwordKey = 'password';

  static registerUser(String email, String password, String passwordRepeat) async {
    email = email.trim();
    password = password.trim();
    passwordRepeat = passwordRepeat.trim();

    if (email.isEmpty) {
      throw AuthEmailEmptyException();
    }
    if (!EmailValidator.validate(email)) {
      throw AuthEmailInvalidException();
    }
    if (password.isEmpty) {
      throw AuthPasswordEmptyException();
    }
    if (password.length < minPasswordLength) {
      throw AuthPasswordTooShortException(minPasswordLength);
    }
    if (password != passwordRepeat) {
      throw AuthPasswordNotMatchException();
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await UserProfile.update();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw AuthPasswordWeakException();
        case 'email-already-in-use':
          throw AuthEmailAlreadyInUseException();
        case 'network-request-failed':
          throw AuthNetworkException();
        default:
          if (kDebugMode) {
            print(e.message);
            print('code: ${e.code}');
          }
          throw AuthUnknownException();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw AuthUnknownException();
    }
    await _saveUser(email, password);
  }

  static loginUser(String email, String password) async {
    email = email.trim();
    password = password.trim();

    if (email.isEmpty) {
      throw AuthEmailEmptyException();
    }
    if (!EmailValidator.validate(email)) {
      throw AuthEmailInvalidException();
    }
    if (password.isEmpty) {
      throw AuthPasswordEmptyException();
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await UserProfile.update();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          throw AuthPasswordWrongException();
        case 'user-not-found':
          throw AuthEmailNotFoundException();
        case 'invalid-credential':
          throw AuthCredentialsInvalidException();
        case 'network-request-failed':
          throw AuthNetworkException();
        default:
          if (kDebugMode) {
            print(e.message);
            print('code: ${e.code}');
          }
          throw AuthUnknownException();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw AuthUnknownException();
    }
    await _saveUser(email, password);
  }

  static _saveUser(String email, String password) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, password);
  }

  static logout() async {
    await FirebaseAuth.instance.signOut();
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);
    await prefs.remove(_passwordKey);
  }

  static Future<bool> autoLogin() async {
    var prefs = await SharedPreferences.getInstance();
    String email = prefs.getString(_emailKey) ?? '';
    String password = prefs.getString(_passwordKey) ?? '';
    try {
      await loginUser(email, password);
    } on AuthNetworkException catch (_) {
      return false;
    } catch (_) {
      await logout();
      return false;
    }
    return true;
  }
}