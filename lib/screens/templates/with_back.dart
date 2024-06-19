import 'package:flutter/cupertino.dart';

import '../../shared/colors.dart';
import 'default.dart';

class ScreenWithBack extends DefaultScreen {
  final VoidCallback? onExitTap;

  const ScreenWithBack({super.key, this.onExitTap});

  @override
  ScreenWithBackState createState() => ScreenWithBackState();
}

class ScreenWithBackState extends DefaultScreenState {
  Widget builder(BuildContext context, Widget? child) {
    return DefaultScreenState.builder(context, Stack(
      children: [
        Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onTap: (widget as ScreenWithBack).onExitTap,
              child: Container(
                height: 45,
                width: 45,
                decoration: const ShapeDecoration(
                  color: StaticColors.button,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    CupertinoIcons.arrow_right,
                    color: StaticColors.buttonText,
                  ),
                ),
              ),
            )),
        Padding(
            padding: const EdgeInsets.fromLTRB(85, 20, 85, 20),
            child: child ?? const Placeholder()
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return builder(context, null);
  }
}