import 'package:flutter/cupertino.dart';

import '../../shared/colors.dart';
import 'default.dart';

class MainScreen extends DefaultScreen {
  final VoidCallback? onExitTap;
  final String title;
  final String subTitle;
  final Widget? footer;

  const MainScreen(
      {super.key,
      this.onExitTap,
      this.title = '',
      this.subTitle = '',
      this.footer});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends DefaultScreenState {
  Widget builder(Widget? child) {
    return DefaultScreenState.builder(Stack(
      children: [
        Positioned(
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
        Padding(
            padding: const EdgeInsets.fromLTRB(85, 20, 85, 20),
            child: child ?? const Placeholder()
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return builder(null);
  }
}
