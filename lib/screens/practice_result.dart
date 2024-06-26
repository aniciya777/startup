import 'package:flutter/material.dart';
import 'package:startup/models/practice/state.dart';
import 'package:startup/screens/practice.dart';
import 'package:startup/screens/templates/with_back.dart';
import 'package:startup/shared/strings.dart';
import 'package:startup/widgets/menu_button.dart';

import '../models/practice/practice.dart';
import '../shared/colors.dart';

class PracticeResultScreen extends ScreenWithBack {
  final PracticeState practiceState;

  const PracticeResultScreen(this.practiceState, {super.key, super.onExitTap});

  @override
  PracticeResultScreenState createState() => PracticeResultScreenState();
}

class PracticeResultScreenState extends ScreenWithBackState {
  late bool result;
  late Practice practice;

  @override
  Widget build(BuildContext context) {
    result = (widget as PracticeResultScreen).practiceState.isComplete!;
    practice = (widget as PracticeResultScreen).practiceState.practice;

    return builder(context, Stack(
      children: [
        Positioned(
          top: 85,
          bottom: 85,
          left: 80,
          right: 80,
          child: Container(
            decoration: ShapeDecoration(
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: StaticColors.buttonText,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Visibility(
            visible: !result,
            child: Center(
              child: SizedBox(
                width: 300,
                child: MenuButton(
                  onTap: repeatPractice,
                  label: StaticStrings.repeatPractice,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Visibility(
            visible: false, // TODO: implement
            // visible: result,
            child: Center(
              child: SizedBox(
                width: 300,
                child: MenuButton(
                  onTap: nextPractice,
                  label: StaticStrings.nextPractice,
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  repeatPractice() {
    Navigator.pushReplacement(context,
      MaterialPageRoute(
        builder: (BuildContext context) => PracticeScreen(practice.getState()),
      ),
    );
  }

  nextPractice() {
    // var theory = (widget as TestResultScreen).theory;
    // var indexQuestion = (widget as TestResultScreen).indexQuestion;
    // Navigator.pushReplacement(context,
    //   MaterialPageRoute(
    //     builder: (BuildContext context) => TestScreen(
    //       theory, indexQuestion + 1
    //     ),
    //   ),
    // );
  }

  Color get color {
    if (result) {
      return StaticColors.practiceSolved;
    } else {
      return StaticColors.practiceNotSolved;
    }
  }

  String get text {
    if (result) {
      return StaticStrings.practiceSolved;
    } else {
      return StaticStrings.practiceNotSolved;
    }
  }
}
