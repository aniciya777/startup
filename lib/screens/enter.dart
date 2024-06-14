import 'dart:async';

import 'package:startup/screens/login.dart';
import 'package:startup/screens/templates/with_back.dart';
import 'package:startup/shared/strings.dart';
import 'package:startup/widgets/menu_button.dart';
import 'package:startup/widgets/menu_input.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../widgets/menu_email.dart';
import '../widgets/menu_password.dart';
import 'home.dart';

class EnterScreen extends ScreenWithBack {
  const EnterScreen({super.key, super.onExitTap});

  @override
  EnterScreenState createState() => EnterScreenState();
}

class EnterScreenState extends ScreenWithBackState {
  static const int minPasswordLength = 8;

  final StreamController<String?> _emailErrorController =
      StreamController<String?>();
  final StreamController<String?> _passwordErrorController =
      StreamController<String?>();
  final StreamController<String?> _repeatPasswordErrorController =
      StreamController<String?>();
  late final MenuInput _emailInput;
  late final MenuPassword _passwordInput;
  late final MenuPassword _repeatPasswordInput;

  @override
  void initState() {
    super.initState();
    _emailInput = MenuEmail(
      label: StaticStrings.email,
      hasNext: true,
      errorStream: _emailErrorController.stream,
    );
    _passwordInput = MenuPassword(
      label: StaticStrings.password,
      hasNext: true,
      errorStream: _passwordErrorController.stream,
    );
    _repeatPasswordInput = MenuPassword(
      label: StaticStrings.repeatPassword,
      hasNext: false,
      errorStream: _repeatPasswordErrorController.stream,
    );
  }

  @override
  Widget build(BuildContext context) {
    return builder(Center(
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _emailInput,
            const SizedBox(height: 15),
            _passwordInput,
            const SizedBox(height: 15),
            _repeatPasswordInput,
            const SizedBox(height: 15),
            MenuButton(label: StaticStrings.register, onTap: register),
            const SizedBox(height: 15),
            MenuButton(label: StaticStrings.toLogin, onTap: toLogin),
          ],
        ),
      ),
    ));
  }

  register() {
    final email = _emailInput.value.trim();
    final password = _passwordInput.value.trim();
    final repeatPassword = _repeatPasswordInput.value.trim();
    try {
      checkEmail(email);
      _emailErrorController.add(null);
    } catch (e) {
      _emailErrorController.add(e.toString().replaceFirst('Exception: ', ''));
      return;
    }
    try {
      checkPassword(password);
      _passwordErrorController.add(null);
    } catch (e) {
      _passwordErrorController
          .add(e.toString().replaceFirst('Exception: ', ''));
      return;
    }
    if (password != repeatPassword) {
      _repeatPasswordErrorController.add('пароли не совпадают');
      return;
    } else {
      _repeatPasswordErrorController.add(null);
    }

    Navigator.pushReplacement(
        context,
        PageTransition(
          alignment: Alignment.center,
          childCurrent: widget,
          type: PageTransitionType.scale,
          duration: const Duration(seconds: 1),
          child: const HomeScreen(),
        ));
  }

  toLogin() {
    Navigator.push(
        context,
        PageTransition(
          alignment: Alignment.center,
          childCurrent: widget,
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 250),
          child: LoginScreen(onExitTap: () => {Navigator.pop(context)}),
        ));
  }

  static void checkEmail(String email) {
    if (email.isEmpty) {
      throw Exception('введите email');
    }
    if (!EmailValidator.validate(email)) {
      throw Exception('некорректный email');
    }
  }

  static void checkPassword(String password) {
    if (password.length < minPasswordLength) {
      throw Exception('не менее $minPasswordLength символов');
    }
  }
}
