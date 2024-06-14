import 'package:startup/shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../models/practice/practice.dart';

class PracticeButton extends StatelessWidget {
  final Practice? practice;

  const PracticeButton({super.key, this.practice});

  @override
  Widget build(BuildContext context) {
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
    return Container();
  }
}
