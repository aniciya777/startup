import 'package:flutter/material.dart';
import 'package:startup/widgets/test_answer.dart';

class TestAnswerRadio extends TestAnswer {
  const TestAnswerRadio(super.answer, super.index, super.parent, {super.key});

  @override
  TestAnswerRadioState createState() => TestAnswerRadioState();
}

class TestAnswerRadioState extends TestAnswerState {
  @override
  Widget get interactionWidget {
    return StreamBuilder<int?>(
      stream: widget.parent.streamController.stream,
      builder: (context, snapshot) {
        return Radio<int>(
          onChanged: (value) {
            onTap();
          },
          value: widget.index,
          groupValue: snapshot.data,
        );
      }
    );
  }

  @override
  onTap() {
    setState(() {
      widget.parent.setRadioValue(widget.index);
    });
  }
}
