import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startup/screens/templates/default.dart';

import '../models/user/auth.dart';

class InitialScreen extends DefaultScreen {
  const InitialScreen({super.key});

  @override
  DefaultScreenState createState() => InitialScreenState();
}

class InitialScreenState extends DefaultScreenState {
  @override
  Widget build(BuildContext context) {
    Auth.autoLogin().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/greetings');
      }
    });

    return DefaultScreenState.builder(context, const Center(
      child:
          SizedBox(height: 100, width: 100, child: CircularProgressIndicator()),
    ));
  }
}
