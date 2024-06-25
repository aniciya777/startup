import 'package:startup/models/practice/strategies/_abstract_strategy.dart';

class Epoch {
  final String text;
  final Strategy on;
  final Strategy off;

  Epoch(this.text, this.on, this.off);

  factory Epoch.fromJson(Map<Object?, dynamic> json) {
    return Epoch(
      json['text'],
      Strategy.fromJson(json['on']),
      Strategy.fromJson(json['off']),
    );
  }
}