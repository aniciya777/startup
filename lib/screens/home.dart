import 'package:flutter/material.dart';
import 'package:startup/models/user/easter_egg.dart';
import 'package:startup/models/user/user.dart';
import 'package:startup/screens/achievements.dart';
import 'package:startup/screens/change_level.dart';
import 'package:startup/shared/strings.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../models/user/auth.dart';
import '../shared/colors.dart';
import '../widgets/menu.dart';
import 'enter.dart';
import 'templates/default.dart';

class HomeScreen extends DefaultScreen {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends DefaultScreenState with TickerProviderStateMixin {
  static const minCountTaps = 10;
  static int countTaps = 0;
  late Animation<double> _animationSize;
  late AnimationController _controllerSize;

  @override
  void initState() {
    super.initState();
    _controllerSize =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animationSize = Tween<double>(begin: 1, end: -1).animate(
      CurvedAnimation(
        parent: _controllerSize,
        curve: Curves.fastOutSlowIn,
      ),
    )..addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScreenState.builder(
        context,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 300,
              child: GestureDetector(
                onTap: iconTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: _animationSize.value <= 0,
                      child: Opacity(
                        opacity: (_animationSize.value > 0) ? 0 : -_animationSize.value,
                        child: Text(
                          EasterEgg.countTaps.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            color: StaticColors.greetingText,
                            fontSize: 40,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 300 * _animationSize.value.abs(),
                      height: 310,
                      decoration: ShapeDecoration(
                        image: DecorationImage(

                          image: AssetImage((_animationSize.value > 0)
                              ? "assets/images/icon.png"
                              : "assets/images/hamster.jpg"),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(65),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Menu(
              labels: const [
                StaticStrings.game,
                StaticStrings.achievements,
                StaticStrings.logout,
                StaticStrings.changeUser,
                StaticStrings.exit,
              ],
              callbacks: [game, achievements, logout, changeUser, exit],
            )
          ],
        ));
  }

  achievements() {
    Navigator.push(
        context,
        PageTransition(
          childCurrent: widget,
          type: PageTransitionType.leftToRightWithFade,
          duration: const Duration(milliseconds: 500),
          child: AchievementsScreen(onExitTap: () => {Navigator.pop(context)}),
        ));
  }

  game() {
    Navigator.push(
        context,
        PageTransition(
          childCurrent: widget,
          alignment: Alignment.center,
          type: PageTransitionType.scale,
          duration: const Duration(milliseconds: 500),
          child: ChangeLevelScreen(onExitTap: () => {Navigator.pop(context)}),
        ));
  }

  changeUser() {
    Navigator.push(
        context,
        PageTransition(
          childCurrent: widget,
          type: PageTransitionType.leftToRightWithFade,
          duration: const Duration(milliseconds: 500),
          child: EnterScreen(onExitTap: () => {Navigator.pop(context)}),
        ));
  }

  exit() {
    SystemNavigator.pop();
  }

  logout() async {
    bool result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(StaticStrings.logoutTitle),
          content: const Text(
            StaticStrings.logoutAlert,
            style: TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(false);
              },
              child: const Text(StaticStrings.noBtn,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop(true);
                await Auth.logout();
              },
              child: const Text(StaticStrings.yesBtn,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (result) {
      Navigator.pushReplacement(
          context,
          PageTransition(
            childCurrent: widget,
            alignment: Alignment.center,
            type: PageTransitionType.scale,
            duration: const Duration(milliseconds: 500),
            child: EnterScreen(onExitTap: () => {Navigator.pop(context)}),
          ));
    }
  }

  iconTap() {
    if (countTaps >= minCountTaps) {
      setState(() {
        EasterEgg.incrementCountTaps();
      });
    } else {
      countTaps++;
      if (countTaps == minCountTaps) {
        EasterEgg();
        _controllerSize.forward();
      }
    }
  }
}
