import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../shared/colors.dart';
import 'default.dart';

class MainScreen extends DefaultScreen {
  final VoidCallback? onExitTap;
  final String title;
  final String? subTitle;

  const MainScreen({super.key, this.onExitTap, this.title = '', this.subTitle});

  @override
  MainScreenState createState() => MainScreenState();

  Widget? get footer {
    return null;
  }
}

class MainScreenState extends DefaultScreenState {
  final _titleStyle = const TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
    decoration: TextDecoration.none,
  );

  Widget builder(BuildContext context, Widget? child) {
    var bottomOffset = (widget as MainScreen).footer == null ? 0 : 54;
    var isSubTitleVisible = (widget as MainScreen).subTitle != null;
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);

    return DefaultScreenState.builder(context, Stack(
      children: [
        Visibility(
          visible: !isKeyboardVisible,
          child: Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: const BoxDecoration(color: StaticColors.back),
            ),
          ),
        ),
        Visibility(
          visible: !isKeyboardVisible,
          child: Positioned(
              top: 28,
              left: 12,
              width: isSubTitleVisible ? 100 : null,
              right: isSubTitleVisible ? null : 20 + 45 + 12,
              child: Text(
                (widget as MainScreen).title,
                style: _titleStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )),
        ),
        Visibility(
          visible: !isKeyboardVisible,
          child: Positioned(
              top: 28,
              left: 112,
              right: 20 + 45 + 12,
              child: Text(
                (widget as MainScreen).subTitle ?? '',
                style: _titleStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )),
        ),
        Visibility(
          visible: !isKeyboardVisible,
          child: Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: (widget as MainScreen).footer ?? Container(),
          ),
        ),
        Visibility(
          visible: !isKeyboardVisible,
          child: Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: (widget as MainScreen).onExitTap,
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
        ),
        Positioned(
          left: 30,
          top: isKeyboardVisible ? 0 : 80 + 30,
          right: 30,
          bottom: bottomOffset + 30,
          child: child ?? const Placeholder()),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return builder(context, null);
  }
}
