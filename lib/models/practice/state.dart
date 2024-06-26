import 'package:intl/intl.dart';
import 'package:startup/models/practice/practice.dart';

class PracticeState {
  static final _formatter = NumberFormat('#,###');
  final Practice practice;
  late int _balance;
  int currentEpoch = 0;
  Map<String, bool> boostsStatus = {
    'ad': true,
    'test': true,
    'survey': true,
  };

  PracticeState(this.practice) {
    _balance = practice.startBalance;
  }

  bool? get isComplete {
    if (_balance >= practice.target) {
      return true;
    }
    if (currentEpoch >= practice.countEpochs) {
      return false;
    }
    return null;
  }

  int get balance => _balance;

  static String formatBalance(int balance) {
    return _formatter.format(balance).replaceAll(',', ' ');
  }

  String get targetText {
    return practice.targetText.
    replaceAll('%TARGET_BALANCE%', formatBalance(practice.target));
  }

  String get text {
    if (currentEpoch >= practice.countEpochs) {
      return '';
    }
    return practice.epochs[currentEpoch].text;
  }

  selectOn() {
    _balance = practice.epochs[currentEpoch].on.make(_balance);
    currentEpoch++;
  }

  selectOff() {
    _balance = practice.epochs[currentEpoch].off.make(_balance);
    currentEpoch++;
  }

  selectBoost(String boost) {
    if (boostsStatus[boost]!) {
      boostsStatus[boost] = false;
      _balance = practice.boosts[boost]!.make(_balance);
    }
  }
}