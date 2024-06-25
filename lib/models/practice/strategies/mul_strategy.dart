import 'package:startup/models/practice/strategies/_abstract_strategy.dart';

class MulStrategy extends Strategy {
  final double _value;

  MulStrategy(this._value);

  @override
  factory MulStrategy.fromJson(Map<Object?, dynamic> json) {
    return MulStrategy(json['value']);
  }

  @override
  int make(int balance) {
    return (balance * _value).round();
  }
}