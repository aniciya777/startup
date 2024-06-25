import 'package:startup/models/practice/strategies/_abstract_strategy.dart';

class AddStrategy extends Strategy {
  final int _value;

  AddStrategy(this._value);

  @override
  factory AddStrategy.fromJson(Map<Object?, dynamic> json) {
    return AddStrategy(json['value']);
  }

  @override
  int make(int balance) {
    return balance + _value;
  }
}