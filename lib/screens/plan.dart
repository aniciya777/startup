import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:startup/screens/templates/main.dart';
import 'package:startup/shared/colors.dart';
import 'package:startup/shared/scheme_plan.dart';
import 'package:startup/shared/strings.dart';

class PlanScreen extends MainScreen {
  static BuildContext? context;
  final int index;

  PlanScreen({super.key, required this.index})
      : super(onExitTap: PlanScreen.exitTap, title: StaticStrings.planTitle);

  @override
  PlanScreenState createState() => PlanScreenState();

  static exitTap() {
    if (context != null) {
      Navigator.of(context!).pop();
    }
  }

  @override
  Widget get footer {
    return Container(
      width: 932,
      height: 54,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      decoration: const BoxDecoration(color: StaticColors.back),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 45,
            height: 45,
            child: prevButton,
          ),
          advice,
          SizedBox(
            width: 45,
            height: 45,
            child: nextButton,
          )
        ],
      ),
    );
  }

  Widget get advice {
    if (SchemePlan.spans[index] == null) {
      return Container();
    }

    var textStyle = const TextStyle(
      color: StaticColors.buttonText,
      fontSize: 24,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w400,
      height: 0,
      decoration: TextDecoration.none,
    );

    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: StaticStrings.advice,
          style: textStyle,
        ),
        SchemePlan.spans[index]!
      ]),
    );
  }

  Widget? get prevButton {
    if (index == 0) {
      return null;
    }

    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () => {openPlan(index - 1)},
      icon: const Icon(
        size: 45,
        CupertinoIcons.arrow_turn_down_left,
        color: StaticColors.buttonText,
      ),
    );
  }

  Widget? get nextButton {
    if (index == SchemePlan.spans.length - 1) {
      return null;
    }

    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () => {openPlan(index + 1)},
      icon: const Icon(
        size: 45,
        CupertinoIcons.arrow_turn_down_right,
        color: StaticColors.buttonText,
      ),
    );
  }

  openPlan(int newIndex) {
    Navigator.pushReplacement(
        context!,
        PageTransition(
          childCurrent: this,
          alignment: Alignment.center,
          type: PageTransitionType.size,
          duration: const Duration(milliseconds: 250),
          child: PlanScreen(index: newIndex),
        ));
  }

  static Widget builder(Widget child) {
    PlanScreen.context = context;
    return child;
  }
}

class PlanScreenState extends MainScreenState {
  @override
  Widget build(BuildContext context) {
    PlanScreen.context = context;
    var index = (widget as PlanScreen).index;

    return builder(Center(
        child: Container(
            width: 730,
            height: 310,
            decoration: const BoxDecoration(
              color: StaticColors.back,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  left: 7,
                  child: Text(
                    '${SchemePlan.labels[index]}:',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      height: 0,
                      decoration: TextDecoration.none,
                    )
                  ),
                )
              ],
            ))));
  }
}
