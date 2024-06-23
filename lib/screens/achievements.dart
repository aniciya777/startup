import 'package:flutter/material.dart';
import 'package:startup/models/achievements/storage.dart';
import 'package:startup/screens/templates/with_back.dart';
import 'package:startup/widgets/achievement.dart';

import '../shared/colors.dart';
import '../shared/strings.dart';

class AchievementsScreen extends ScreenWithBack {
  const AchievementsScreen({super.key, super.onExitTap});

  @override
  AchievementsScreenState createState() => AchievementsScreenState();
}

class AchievementsScreenState extends ScreenWithBackState {
  final _scrollController = ScrollController();

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
        child: Stack(
          children: [
            const Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Text(
                StaticStrings.achievements,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: StaticColors.buttonText,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                  decoration: TextDecoration.none
                ),
              )
            ),
            Positioned(
              top: 70,
              left: 0,
              right: 0,
              bottom: 0,
              child: Scrollbar(
                controller: _scrollController,
                thickness: 10.0,
                thumbVisibility: true,
                trackVisibility: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: AchievementStorage.size,
                    itemBuilder: (context, index) {
                      return AchievementView(achievement: AchievementStorage.get(index));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 15);
                    },
                  ),
                ),
              )
            )
          ],
        )
      ),
    ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
