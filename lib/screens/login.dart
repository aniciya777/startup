import 'dart:async';

import 'package:startup/screens/enter.dart';
import 'package:startup/screens/templates/with_back.dart';
import 'package:startup/shared/strings.dart';
import 'package:startup/widgets/menu_button.dart';
import 'package:startup/widgets/menu_input.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
            MenuButton(label: StaticStrings.login, onTap: login),
            const SizedBox(height: 15),
            MenuButton(label: StaticStrings.toRegister, onTap: toRegister),
          ],
        ),
      ),
    ));
  }

  login() {
    final email = _emailInput.value.trim();
    final password = _passwordInput.value.trim();
    // TODO

    _emailErrorController.add(null);
    _passwordErrorController.add(null);
  }

  toRegister() {
    Navigator.pop(context);
  }
}
