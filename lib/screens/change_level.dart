import 'package:startup/screens/change_practice.dart';
import 'package:startup/screens/plan_preview.dart';
import 'package:startup/screens/templates/with_back.dart';
import 'package:startup/shared/colors.dart';
import 'package:startup/shared/strings.dart';
import 'package:startup/widgets/chapter_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';

import 'change_theory.dart';

class ChangeLevelScreen extends ScreenWithBack {
  const ChangeLevelScreen({super.key, super.onExitTap});

  @override
  ChangeLevelScreenState createState() => ChangeLevelScreenState();
}

class ChangeLevelScreenState extends ScreenWithBackState {
  final List<ChapterButton> chapterButtons = [];

  @override
  void initState() {
    super.initState();
    chapterButtons.add(ChapterButton(
      image: const AssetImage('assets/images/chapters/theory.png'),
      title: StaticStrings.chapterTitles[0],
      onTap: openTheory,
    ));
    chapterButtons.add(ChapterButton(
      image: const AssetImage('assets/images/chapters/practice.png'),
      title: StaticStrings.chapterTitles[1],
      onTap: openPractice,
    ));
    chapterButtons.add(ChapterButton(
      image: const AssetImage('assets/images/chapters/my_plan.png'),
      title: StaticStrings.chapterTitles[2],
      onTap: openMyPlan,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return builder(context, Center(
      child: Container(
        width: 730,
        height: 310,
        decoration: const BoxDecoration(
          color: StaticColors.back,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: chapterButtons,
          ),
        ),
      ),
    ));
  }

  openTheory() {
    Navigator.push(
        context,
        PageTransition(
          childCurrent: chapterButtons[0],
          alignment: Alignment.center,
          type: PageTransitionType.size,
          duration: const Duration(milliseconds: 250),
          child:
          ChangeTheoryScreen(onExitTap: () => {Navigator.pop(context)}),
        ));
  }

  openPractice() {
    Navigator.push(
        context,
        PageTransition(
          childCurrent: chapterButtons[1],
          alignment: Alignment.center,
          type: PageTransitionType.size,
          duration: const Duration(milliseconds: 250),
          child:
              ChangePracticeScreen(onExitTap: () => {Navigator.pop(context)}),
        ));
  }

  openMyPlan() {
    Navigator.push(
        context,
        PageTransition(
          childCurrent: chapterButtons[1],
          alignment: Alignment.center,
          type: PageTransitionType.size,
          duration: const Duration(milliseconds: 250),
          child:
          const PlanPreviewScreen(),
        ));
  }
}
