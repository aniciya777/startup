import 'dart:async';

import 'package:startup/models/user/_exceptions.dart';
import 'package:startup/screens/login.dart';
import 'package:startup/screens/templates/with_back.dart';
import 'package:startup/shared/strings.dart';
import 'package:startup/widgets/menu_button.dart';
import 'package:startup/widgets/menu_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../models/user/auth.dart';
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
    return builder(context, Center(
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

  register() async {
    final email = _emailInput.value;
    final password = _passwordInput.value;
    final repeatPassword = _repeatPasswordInput.value;
    _emailErrorController.add(null);
    _passwordErrorController.add(null);
    _repeatPasswordErrorController.add(null);

    try {
      await Auth.registerUser(email, password, repeatPassword);
    } on AuthEmailException catch (e) {
      _emailErrorController.add(e.toString());
      return;
    } on AuthPasswordException catch (e) {
      _passwordErrorController.add(e.toString());
      return;
    } on AuthPasswordRepeatException catch (e) {
      _repeatPasswordErrorController.add(e.toString());
      return;
    } on AuthException catch (e) {
      _emailErrorController.add(e.toString());
      return;
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
}
