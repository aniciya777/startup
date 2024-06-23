import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:startup/models/tests/test_case.dart';
import 'package:startup/models/tests/user_mixin.dart';
import 'package:startup/screens/templates/main.dart';
import 'package:startup/screens/test_result.dart';
import 'package:startup/shared/colors.dart';
import 'package:startup/widgets/test_answer_radio.dart';

import '../models/theory/theory.dart';
import '../shared/strings.dart';
import '../widgets/menu_button.dart';
import '../widgets/test_answer_check.dart';

class TestScreen extends MainScreen {
  late final Theory theory;
  late final int indexQuestion;
  late final TestCase testCase;
  static BuildContext? context;
  final streamController = StreamController<int?>.broadcast();

  late final List<bool> flags;

  TestScreen(this.theory, this.indexQuestion, {super.key, initialTestCase})
      : super(
    onExitTap: TestScreen.exitTap,
    title: StaticStrings.test,
    subTitle: theory.title,
  ) {
    testCase = initialTestCase ?? theory.getCase(indexQuestion);
    flags = testCase.answers.map((_) => false).toList();
  }

  @override
  TestScreenState createState() => TestScreenState();

  static exitTap() {
    if (context != null) {
      Navigator.of(context!).pop();
    }
  }

  @override
  Widget? get footer {
    return Center(
      child: Container(
        width: 300,
        padding: const EdgeInsets.only(bottom: 15),
        child: MenuButton(
          label: StaticStrings.getAnswer,
          onTap: getAnswer,
        ),
      )
    );
  }

  int? get answerGroupValue {
    int? value;
    for (int i = 0; i < flags.length; i++) {
      if (flags[i]) {
        if (value != null) {
          return null;
        }
        value = i;
      }
    }
    return value;
  }

  setRadioValue(int value) {
    for (int i = 0; i < flags.length; i++) {
      flags[i] = i == value;
    }
    streamController.add(value);
  }

  getAnswer() {
    if (!testCase.multipleChoice && answerGroupValue == null) {
      Fluttertoast.showToast(
        msg: StaticStrings.errorNotAnswer,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 20.0,
        webShowClose: true,
      );
      return;
    }
    var result = testCase.checkAnswer(flags);
    if (!result) {
      TestUserMixin.uncompleteTest(theory.id).then((_) {});
    } else if (indexQuestion == theory.testsCount - 1) {
      TestUserMixin.completeTest(theory.id).then((_) {});
    }
    Navigator.pushReplacement(context!,
      MaterialPageRoute(
        builder: (BuildContext context) => TestResultScreen(
            theory, indexQuestion, testCase, result, onExitTap: () {Navigator.of(context).pop();}
        ),
      ),
    );
  }
}

class TestScreenState extends MainScreenState {
  final ScrollController _scrollController = ScrollController();
  late final int index;
  late final int count;
  late final TestCase testCase;

  @override
  void initState() {
    super.initState();
    index = (widget as TestScreen).indexQuestion;
    count = (widget as TestScreen).theory.testsCount;
    testCase = (widget as TestScreen).testCase;
  }

  @override
  Widget build(BuildContext context) {
    TestScreen.context = context;

    return builder(context, Container(
      width: double.infinity,
      height: double.infinity,
      decoration: ShapeDecoration(
        color: StaticColors.back,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 7,
            right: 7,
            child: Text(
              '${index + 1}/$count',
              style: const TextStyle(
                color: StaticColors.buttonText,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Positioned(
            top: 7,
            left: 7,
            right: 0,
            bottom: 0,
            child: Scrollbar(
              controller: _scrollController,
              thickness: 10.0,
              thumbVisibility: true,
              trackVisibility: true,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: answers,
                  ),
                ),
              ),
            )
          ),
        ],
      ),
    ));
  }

  Widget get questionText {
    return Text(
      testCase.text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        height: 1.5,
        decoration: TextDecoration.none,
      ),
    );
  }

  List<Widget> get answers {
    List<Widget> elements = [questionText];
    for (var i = 0; i < testCase.answers.length; i++) {
      elements.add(const SizedBox(height: 10));
      if (testCase.multipleChoice) {
        elements.add(TestAnswerCheck(testCase.answers[i], i, widget as TestScreen));
      } else {
        elements.add(TestAnswerRadio(testCase.answers[i], i, widget as TestScreen));
      }
    }
    elements.add(const SizedBox(height: 10));
    return elements;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
