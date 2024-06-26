import 'package:page_transition/page_transition.dart';
import 'package:startup/screens/practice.dart';
import 'package:startup/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../models/practice/practice.dart';
import '../models/practice/status.dart';

class PracticeButton extends StatelessWidget {
  final Practice? practice;
  late BuildContext _context;

  PracticeButton(this.practice, {super.key});

  @override
  Widget build(BuildContext context) {
    _context = context;

    if (practice == null) {
      return _buildNull();
    }
    return _buildPractice();
  }

  Widget _buildNull() {
    return Container(
      decoration: const BoxDecoration(color: StaticColors.practice),
      child: Center(
        child: SvgPicture.asset('assets/vectors/practice_lock.svg')
      ),
    );
  }

  Widget _buildPractice() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: color),
        child: Center(
          child: Text(
            practice!.id.toString(),
            style: const TextStyle(
              color: StaticColors.buttonText,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
              decoration: TextDecoration.none
            ),
          ),
        ),
      ),
    );
  }

  onTap() {
    Navigator.push(
        _context,
        PageTransition(
          alignment: Alignment.center,
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 250),
          child: PracticeScreen(practice!.getState()),
        ));
  }

  Color get color {
    switch (practice!.status) {
      case PracticeStatus.unvisited:
        return StaticColors.practice;
      case PracticeStatus.completed:
        return StaticColors.practiceSolved;
      case PracticeStatus.uncompleted:
        return StaticColors.practiceNotSolved;
      default:
        return StaticColors.back;
    }
  }
}
