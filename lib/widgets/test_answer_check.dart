import 'package:flutter/material.dart';
import 'package:startup/widgets/test_answer.dart';

class TestAnswerCheck extends TestAnswer {
  const TestAnswerCheck(super.answer, super.index, super.parent, {super.key});

  @override
  TestAnswerCheckState createState() => TestAnswerCheckState();
}

class TestAnswerCheckState extends TestAnswerState {
  bool selected = false;

  @override
  Widget get interactionWidget {
    return Checkbox(
      onChanged: (_) {
        onTap();
      },
      value: selected,
    );
  }

  @override
  onTap() {
    setState(() {
      selected = !selected;
    });
    widget.parent.flags[widget.index] = selected;
  }
}
