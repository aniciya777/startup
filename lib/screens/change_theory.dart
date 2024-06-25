import 'package:startup/models/theory/storage.dart';
import 'package:startup/screens/templates/with_back.dart';
import 'package:startup/shared/colors.dart';
import 'package:startup/shared/strings.dart';
import 'package:flutter/material.dart';
import 'package:startup/widgets/theory_button.dart';

class ChangeTheoryScreen extends ScreenWithBack {
  const ChangeTheoryScreen({super.key, super.onExitTap});

  @override
  ChangeTheoryScreenState createState() => ChangeTheoryScreenState();
}

class ChangeTheoryScreenState extends ScreenWithBackState {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      Container(
          width: double.infinity,
          height: double.infinity,
          decoration: ShapeDecoration(
            color: StaticColors.back,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
          child: Stack(
            children: [
              const Positioned(
                  top: 0,
                  left: 0,
                  child: Text(
                    StaticStrings.theoryTitle,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        decoration: TextDecoration.none),
                  )),
              Positioned(
                top: 48,
                left: 0,
                right: 0,
                bottom: 0,
                child: StreamBuilder<Object?>(
                    stream: TheoryStorage.instance.stream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SizedBox(
                              height: 100,
                              width: 100,
                              child: CircularProgressIndicator()),
                        );
                      }
                      return Scrollbar(
                        controller: _scrollController,
                        thickness: 10.0,
                        thumbVisibility: true,
                        trackVisibility: true,
                        child: ListView.builder(
                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 50),
                            controller: _scrollController,
                            itemCount: TheoryStorage.instance.size,
                            itemBuilder: (context, index) {
                              return TheoryButton(
                                  theory: TheoryStorage.instance.get(index)!);
                            }),
                      );
                    }),
              )
            ],
          )),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
