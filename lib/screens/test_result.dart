import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startup/screens/templates/with_back.dart';
import 'package:startup/screens/test.dart';
import 'package:startup/shared/strings.dart';
import 'package:startup/widgets/menu_button.dart';

import '../models/tests/test_case.dart';
import '../models/theory/theory.dart';
import '../shared/colors.dart';

class TestResultScreen extends ScreenWithBack {
  final Theory theory;
  final int indexQuestion;
  final TestCase testCase;
  final bool result;

  const TestResultScreen(this.theory, this.indexQuestion, this.testCase, this.result,
      {super.key, super.onExitTap});

  @override
  TestResultScreenState createState() => TestResultScreenState();

}

class TestResultScreenState extends ScreenWithBackState {
  @override
  Widget build(BuildContext context) {
    var result = (widget as TestResultScreen).result;
    var indexQuestion = (widget as TestResultScreen).indexQuestion;
    var countQuestions = (widget as TestResultScreen).theory.testsCount;

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
                  onTap: repeatAnswer,
                  label: StaticStrings.repeatAnswer,
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
            visible: result && indexQuestion < countQuestions - 1,
            child: Center(
              child: SizedBox(
                width: 300,
                child: MenuButton(
                  onTap: nextQuestion,
                  label: StaticStrings.nextTest,
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  repeatAnswer() {
    var theory = (widget as TestResultScreen).theory;
    var indexQuestion = (widget as TestResultScreen).indexQuestion;
    var testCase = (widget as TestResultScreen).testCase;
    Navigator.pushReplacement(context,
      MaterialPageRoute(
        builder: (BuildContext context) => TestScreen(
            theory, indexQuestion, initialTestCase: testCase
        ),
      ),
    );
  }

  nextQuestion() {
    var theory = (widget as TestResultScreen).theory;
    var indexQuestion = (widget as TestResultScreen).indexQuestion;
    Navigator.pushReplacement(context,
      MaterialPageRoute(
        builder: (BuildContext context) => TestScreen(
          theory, indexQuestion + 1
        ),
      ),
    );
  }

  Color get color {
    if ((widget as TestResultScreen).result) {
      return StaticColors.practiceSolved;
    } else {
      return StaticColors.practiceNotSolved;
    }
  }

  String get text {
    if ((widget as TestResultScreen).result) {
      return StaticStrings.testSolved;
    } else {
      return StaticStrings.testNotSolved;
    }
  }
}
