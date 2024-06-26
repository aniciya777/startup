import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:startup/models/practice/state.dart';
import 'package:startup/models/practice/user_mixin.dart';
import 'package:startup/screens/practice_result.dart';
import 'package:startup/screens/templates/main.dart';
import 'package:startup/shared/colors.dart';
import 'package:startup/shared/strings.dart';
import 'package:startup/widgets/boost_button.dart';

class PracticeScreen extends MainScreen {
  final PracticeState practiceState;
  static BuildContext? context;

  PracticeScreen(this.practiceState, {super.key})
    : super(
      onExitTap: PracticeScreen.exitTap,
      title: StaticStrings.balance,
      subTitle: PracticeState.formatBalance(practiceState.balance),
  );

  @override
  PracticeScreenState createState() => PracticeScreenState();

  static exitTap() {
    if (context != null) {
      Navigator.of(context!).pop();
    }
  }

  @override
  Widget? get footer {
    return Container(
      height: 60,
      decoration: const BoxDecoration(color: StaticColors.back),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            height: 10,
            top: 0,
            child: LinearProgressIndicator(
              value: practiceState.balance / practiceState.practice.target,
              color: const Color(0xFF47C51A),
              backgroundColor: StaticColors.back,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            height: 54,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                "Цель: ${practiceState.targetText}",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: StaticColors.buttonText,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  decoration: TextDecoration.none,
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}

class PracticeScreenState extends MainScreenState {
  final ScrollController _scrollController = ScrollController();
  late PracticeState practiceState;

  @override
  Widget build(BuildContext context) {
    PracticeScreen.context = context;
    practiceState = (widget as PracticeScreen).practiceState;
    var epoch = practiceState.currentEpoch;
    var allEpochs = practiceState.practice.countEpochs;

    return builder(context, Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: 65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoostButton(practiceState, StaticStrings.boostTitles[0], 'ad', _nextEpoch),
              BoostButton(practiceState, StaticStrings.boostTitles[1], 'test', _nextEpoch),
              BoostButton(practiceState, StaticStrings.boostTitles[2], 'survey', _nextEpoch),
            ],
          ),
        ),
        Positioned(
          right: 35,
          top: 0,
          bottom: 0,
          width: 65,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: 65,
                onPressed: onTapOn,
                icon: const Icon(
                  Icons.check_box,
                  color: Color(0xFF47C51A),
                )
              ),
              IconButton(
                  iconSize: 65,
                  onPressed: onTapOff,
                  icon: const Icon(
                    Icons.indeterminate_check_box,
                    color: Color(0xFFCD1D1D),
                  )
              )
            ],
          ),
        ),
        Positioned(
          left: 135,
          right: 135,
          top: 0,
          bottom: 0,
          child: Container(
            decoration: ShapeDecoration(
              color: StaticColors.back,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: Scrollbar(
                  thickness: 10,
                  thumbVisibility: true,
                  trackVisibility: true,
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(35, 0, 50, 0),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Text(
                        practiceState.text,
                        style: const TextStyle(
                          color: StaticColors.buttonText,
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ),
        Positioned(
          right: 135 + 20,
          top: 7,
          child: Text(
            '${epoch + 1}/${allEpochs}',
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
      ],
    ));
  }

  onTapOn() {
    practiceState.selectOn();
    _nextEpoch();
  }

  onTapOff() {
    practiceState.selectOff();
    _nextEpoch();
  }

  _close() {
    if (practiceState.isComplete!) {
      PracticeUserMixin.completePractice(practiceState.practice.id).then((_) {});
    } else {
      PracticeUserMixin.uncompletePractice(practiceState.practice.id).then((_) {});
    }
    Navigator.pushReplacement(context,
      MaterialPageRoute(
        builder: (BuildContext context) => PracticeResultScreen(
          practiceState,
          onExitTap: () {Navigator.of(context).pop();},
        ),
      ),
    );
  }

  _nextEpoch() {
    if (practiceState.isComplete != null) {
      _close();
      return;
    }
    Navigator.pushReplacement(
        context,
        PageTransition(
          alignment: Alignment.center,
          type: PageTransitionType.fade,
          duration: const Duration(),
          child: PracticeScreen(practiceState),
        ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}