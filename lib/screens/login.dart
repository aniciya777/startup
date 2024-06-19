import 'dart:async';

import 'package:page_transition/page_transition.dart';
import 'package:startup/screens/templates/with_back.dart';
import 'package:startup/shared/strings.dart';
import 'package:startup/widgets/menu_button.dart';
import 'package:startup/widgets/menu_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user/_exceptions.dart';
import '../models/user/auth.dart';
import '../widgets/menu_email.dart';
import '../widgets/menu_password.dart';
import 'home.dart';

class LoginScreen extends ScreenWithBack {
  const LoginScreen({super.key, super.onExitTap});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ScreenWithBackState {
  static const int minPasswordLength = 8;

  final StreamController<String?> _emailErrorController =
      StreamController<String?>();
  final StreamController<String?> _passwordErrorController =
      StreamController<String?>();
  late final MenuInput _emailInput;
  late final MenuPassword _passwordInput;

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
            MenuButton(label: StaticStrings.login, onTap: login),
            const SizedBox(height: 15),
            MenuButton(label: StaticStrings.toRegister, onTap: toRegister),
          ],
        ),
      ),
    ));
  }

  login() async {
    final email = _emailInput.value;
    final password = _passwordInput.value;
    _emailErrorController.add(null);
    _passwordErrorController.add(null);

    try {
      await Auth.loginUser(email, password);
    } on AuthEmailException catch (e) {
      _emailErrorController.add(e.toString());
      return;
    } on AuthPasswordException catch (e) {
      _passwordErrorController.add(e.toString());
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

  toRegister() {
    Navigator.pop(context);
  }
}
