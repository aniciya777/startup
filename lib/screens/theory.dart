import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:startup/models/theory/theory.dart';
import 'package:startup/screens/templates/main.dart';
import 'package:startup/shared/strings.dart';

import '../shared/colors.dart';
import '../shared/markdown.dart';

class TheoryScreen extends MainScreen {
  late final Theory theory;
  static BuildContext? context;

  TheoryScreen(Theory theory, {key})
      : super(
          key: key,
          onExitTap: TheoryScreen.exitTap,
          title: StaticStrings.topic,
          subTitle: theory.title,
        ) {
    this.theory = theory;
  }

  @override
  TheoryScreenState createState() => TheoryScreenState();

  @override
  Widget get footer {
    return Container(
      height: 54,
      decoration: const BoxDecoration(color: StaticColors.back),
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: () => {},
        child: const Text(
          StaticStrings.testOnTopic,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
            decorationColor: Colors.black,
            decorationStyle: TextDecorationStyle.solid,
            height: 0,
          ),
        ),
      ),
    );
  }

  static exitTap() {
    if (context != null) {
      Navigator.of(context!).pop();
    }
  }
}

class TheoryScreenState extends MainScreenState {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    TheoryScreen.context = context;

    return builder(Container(
        width: double.infinity,
        height: double.infinity,
        decoration: ShapeDecoration(
          color: StaticColors.back,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        padding: const EdgeInsets.all(7),
        child: Scrollbar(
          controller: _controller,
          thickness: 10.0,
          thumbVisibility: true,
          trackVisibility: true,
          child: Markdown(
            data: (widget as TheoryScreen).theory.text,
            selectable: false,
            controller: _controller,
            styleSheet: StaticMarkdown.getStyle(),
          ),
        )));
  }
}
