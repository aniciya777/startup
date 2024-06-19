import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/achievements/achievement.dart';
import '../shared/colors.dart';

class AchievementView extends StatefulWidget {
  final Achievement? achievement;

  const AchievementView({super.key, this.achievement});

  @override
  State<AchievementView> createState() => _AchievementViewState();
}

class _AchievementViewState extends State<AchievementView> {
  Color _color = StaticColors.practice;

  @override
  void initState() {
    super.initState();
    if (widget.achievement!= null) {
      widget.achievement!.isCompleted.then((value) {
        if (value) {
          setState(() {
            _color = StaticColors.practiceSolved;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.achievement == null) {
      return _buildNull();
    }
    return _buildAchievement();
  }

  Widget _buildNull() {
    return Container(
      width: 620,
      height: 65,
      decoration: BoxDecoration(color: _color),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Center(
            child: SvgPicture.asset('assets/vectors/practice_lock.svg')
        ),
      ),
    );
  }

  Widget _buildAchievement() {
    return Container(
      width: 620,
      height: 65,
      decoration: BoxDecoration(color: _color),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Text(
          widget.achievement!.label,
          style: const TextStyle(
            color: StaticColors.buttonText,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 0,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
