import 'add_strategy.dart';
import 'empty_strategy.dart';
import 'mul_strategy.dart';

abstract class Strategy {
  Strategy() {
    throw UnimplementedError();
  }

  factory Strategy.fromJson(Map<Object?, dynamic> json) {
    switch (json['type']) {
      case null:
        return EmptyStrategy();
      case '+':
        return AddStrategy.fromJson(json);
      case '*':
        return MulStrategy.fromJson(json);
      default:
        throw UnimplementedError();
    }
  }

  int make(int balance);
}