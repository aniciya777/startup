import 'package:startup/screens/templates/with_back.dart';
import 'package:flutter/cupertino.dart';

class ChangeTheoryScreen extends ScreenWithBack {
  const ChangeTheoryScreen({super.key, super.onExitTap});

  @override
  ChangeTheoryScreenState createState() => ChangeTheoryScreenState();
}

class ChangeTheoryScreenState extends ScreenWithBackState {
  @override
  Widget build(BuildContext context) {
    return builder(
      Placeholder()
    );
  }
}
