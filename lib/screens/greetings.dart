import 'package:startup/screens/templates/default.dart';
import 'package:startup/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../shared/strings.dart';
import 'enter.dart';

class GreetingsScreen extends DefaultScreen {
  const GreetingsScreen({super.key});

  @override
  GreetingsScreenState createState() => GreetingsScreenState();
}

class GreetingsScreenState extends DefaultScreenState
    with TickerProviderStateMixin {
  late Animation<double> _animationSize;
  late Animation<double> _animationOpacity;
  late AnimationController _controllerSize;
  late AnimationController _controllerOpacity;

  final double _size = 300;
  final double _originalSize = 1500;

  var _animated = false;

  @override
  void initState() {
    super.initState();
    _controllerSize =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _controllerOpacity =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animationSize = Tween<double>(begin: 0.1, end: 1).animate(_controllerSize)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _controllerOpacity.forward();
        }
      });
    _animationOpacity = Tween<double>(begin: 1, end: 0).animate(_controllerSize)
      ..addListener(() {
        setState(() {});
      })
     ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacement(context, PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(seconds: 2),
            child: EnterScreen(onExitTap: () => {SystemNavigator.pop()}),
          ));
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreenState.builder(context, GestureDetector(
      onTap: () {
        _controllerSize.forward();
        setState(() {
          _animated = true;
        });
      },
      onDoubleTap: () {
        Navigator.pushReplacementNamed(context, '/enter');
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 1 - _animationOpacity.value)
        ),
        child: Opacity(
          opacity: _animationOpacity.value,
          child: Center(
              child: SizedBox(
            width: _size,
            height: _size + 80,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: (_size - _originalSize) / 2,
                  top: (_size - _originalSize) / 2,
                  child: Container(
                    width: _originalSize,
                    height: _originalSize,
                    decoration: ShapeDecoration(
                      gradient: RadialGradient(
                        center: const Alignment(0, 0),
                        radius: _animationSize.value,
                        colors: const [
                          StaticColors.greetingStartColor,
                          StaticColors.greetingEndColor
                        ],
                      ),
                      shape: const OvalBorder(),
                    ),
                  ),
                ),
                Visibility(
                  visible: !_animated,
                  child: const Positioned(
                    left: 0,
                    right: 0,
                    top: 308,
                    child: Text(
                      StaticStrings.greeting,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: StaticColors.greetingText,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    _controllerSize.dispose();
    _controllerOpacity.dispose();
    super.dispose();
  }
}
