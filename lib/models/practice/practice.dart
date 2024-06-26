import 'package:startup/models/practice/state.dart';
import 'package:startup/models/practice/status.dart';
import 'package:startup/models/practice/strategies/_abstract_strategy.dart';

import 'boost.dart';
import 'epoch.dart';

class Practice {
  final int id;
  final String targetText;
  final int target;
  final int startBalance;
  PracticeStatus status = PracticeStatus.unvisited;

  final Map<String, Boost> boosts = {
    'ad': Boost('ad'),
    'test': Boost('test'),
    'survey': Boost('survey'),
  };
  List<Epoch> epochs = [];

  Practice({
    required this.id,
    required this.startBalance,
    required this.targetText,
    required this.target,
  });

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
    for (var epoch in (json['epoches'] as List<dynamic>)) {
      obj.epochs.add(Epoch.fromJson(epoch));
    }
    return obj;
  }

  bool? get isComplete {
    return null;
  }

  int get countEpochs => epochs.length;
  
  PracticeState getState() {
    return PracticeState(this);
  }
}