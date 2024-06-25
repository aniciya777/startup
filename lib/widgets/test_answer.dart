import 'package:flutter/material.dart';
import 'package:startup/screens/test.dart';
import 'package:startup/shared/colors.dart';

abstract class TestAnswer extends StatefulWidget {
  final String answer;
  final int index;
  final TestScreen parent;

  const TestAnswer(this.answer, this.index, this.parent, {super.key});
}

abstract class TestAnswerState extends State<TestAnswer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            interactionWidget,
            const SizedBox(width: 10),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  widget.answer,
                  style: const TextStyle(
                    color: StaticColors.buttonText,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get interactionWidget;

  onTap();
}
