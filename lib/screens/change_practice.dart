import 'package:startup/models/practice/storage.dart';
import 'package:startup/screens/templates/with_back.dart';
import 'package:startup/shared/colors.dart';
import 'package:startup/widgets/practice_button.dart';
import 'package:flutter/material.dart';

class ChangePracticeScreen extends ScreenWithBack {
  const ChangePracticeScreen({super.key, super.onExitTap});

  @override
  ChangePracticeScreenState createState() => ChangePracticeScreenState();
}

class ChangePracticeScreenState extends ScreenWithBackState {
  late List<Widget> practices;

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      Container(
        decoration: ShapeDecoration(
          color: StaticColors.back,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Scrollbar(
          controller: _scrollController,
          thickness: 10.0,
          thumbVisibility: true,
          trackVisibility: true,
          child: StreamBuilder<Object?>(
              stream: PracticeStorage().stream(),
              builder: (context, snapshot) {
                practices = PracticeStorage().getPractices().map((practice) {
                  return PracticeButton(practice);
                }).toList();

                return GridView.count(
                  controller: _scrollController,
                  primary: false,
                  padding: const EdgeInsets.all(50),
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 15,
                  crossAxisCount: 6,
                  children: practices,
                );
              }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
