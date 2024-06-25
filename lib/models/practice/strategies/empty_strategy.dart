import '_abstract_strategy.dart';

class EmptyStrategy extends Strategy {
  static final EmptyStrategy _singleton = EmptyStrategy._internal();

  factory EmptyStrategy() {
    return _singleton;
  }

  EmptyStrategy._internal();

  @override
  int make(int balance) {
    return balance;
  }
}
