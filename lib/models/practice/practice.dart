import 'package:intl/intl.dart';
import 'package:startup/models/practice/strategies/_abstract_strategy.dart';

import 'boost.dart';
import 'epoch.dart';

class Practice {
  static final _formatter = NumberFormat('#,###');

  final int id;
  late final String _targetText;
  final int target;
  final int startBalance;
  late int _balance;
  int _currentEpoch = 0;

  final Map<String, Boost> boosts = {
    'ad': Boost('ad'),
    'test': Boost('test'),
    'survey': Boost('survey'),
  };
  List<Epoch> _epochs = [];

  Practice({
    required this.id,
    required this.startBalance,
    required targetText,
    required this.target,
  }) {
    _targetText = targetText;
    _balance = startBalance;
  }

  factory Practice.fromJson(Map<Object?, dynamic> json) {
    Practice obj = Practice(
      id: json['id'],
      startBalance: json['start_balance'],
      targetText: json['target']['text'],
      target: json['target']['balance'],
    );
    for (var boost in (json['boosts'] as Map<Object?, dynamic>).keys) {
      obj.boosts[boost]?.setStrategy(
        Strategy.fromJson(json['boosts'][boost]),
      );
    }
    for (var epoch in json['epochs'] as List<dynamic>) {
      obj._epochs.add(Epoch.fromJson(epoch));
    }
    return obj;
  }

  static String formatBalance(int balance) {
    return _formatter.format(balance).replaceAll(',', ' ');
  }

  String get targetText {
    return _targetText.
      replaceAll('%TARGET_BALANCE%', formatBalance(target));
  }

  int get balance => _balance;

  bool? get isComplete {
    if (_balance >= target) {
      return true;
    }
    if (_currentEpoch >= _epochs.length) {
      return false;
    }
    return null;
  }
}