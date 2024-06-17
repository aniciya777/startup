import 'package:flutter/material.dart';
import 'package:startup/screens/change_level.dart';
import 'package:startup/shared/strings.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../models/user/auth.dart';
import '../widgets/menu.dart';
import 'enter.dart';
import 'templates/default.dart';

class HomeScreen extends DefaultScreen {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends DefaultScreenState {
  @override
  Widget build(BuildContext context) {
    return DefaultScreenState.builder(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 300,
          height: 310,
          decoration: ShapeDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/images/home_icon.png"),
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(65),
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
          callbacks: [
            game,
            achievements,
            logout,
            changeUser,
            exit
          ],
        )
      ],
    ));
  }

  achievements() {
    // TODO
  }

  game() {
    Navigator.push(
        context,
        PageTransition(
          childCurrent: widget,
          alignment: Alignment.center,
          type: PageTransitionType.scale,
          duration: const Duration(milliseconds: 500),
          child:
          ChangeLevelScreen(onExitTap: () => {Navigator.pop(context)}),
        ));
  }

  changeUser() {
    Navigator.push(
        context,
        PageTransition(
          childCurrent: widget,
          type: PageTransitionType.leftToRightWithFade,
          duration: const Duration(milliseconds: 500),
          child:
          EnterScreen(onExitTap: () => {Navigator.pop(context)}),
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
          content: const Text(StaticStrings.logoutAlert, style: TextStyle(fontSize: 20),),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pop(false);
              },
              child: const Text(StaticStrings.noBtn, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context, rootNavigator: true)
                    .pop(true);
                await Auth.logout();
              },
              child: const Text(StaticStrings.yesBtn, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
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
            child:
            EnterScreen(onExitTap: () => {Navigator.pop(context)}),
          ));
    }
  }
}
