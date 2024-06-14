import 'package:startup/screens/change_level.dart';
import 'package:startup/shared/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

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
            StaticStrings.newGame,
            StaticStrings.continue_,
            StaticStrings.achievements,
            StaticStrings.changeUser,
            StaticStrings.exit,
          ],
          callbacks: [
            newGame,
            game,
            achievements,
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

  newGame() {
    // TODO
    game();
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
}
