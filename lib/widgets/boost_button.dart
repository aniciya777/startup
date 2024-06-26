import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startup/shared/colors.dart';

import '../models/practice/state.dart';

class BoostButton extends StatelessWidget {
  final PracticeState practiceState;
  final String text;
  final String boostKey;
  final VoidCallback voidCallback;

  const BoostButton(
    this.practiceState,
    this.text,
    this.boostKey,
    this.voidCallback,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: 65,
          height: 65,
          decoration: const BoxDecoration(color: Colors.white),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: StaticColors.buttonText,
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
                decoration: TextDecoration.none,
              ),
            ),
          )
        ),
      ),
    );
  }

  onTap() {
    practiceState.selectBoost(boostKey);
    voidCallback();
  }

  double get opacity {
    if (practiceState.boostsStatus[boostKey] ?? false) {
      return 1;
    } else {
      return 0.5;
    }
  }
}
