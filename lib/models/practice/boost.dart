import 'package:startup/models/practice/strategies/_abstract_strategy.dart';
import 'package:startup/models/practice/strategies/empty_strategy.dart';

class Boost {
  final String name;
  Strategy _strategy = EmptyStrategy();

  Boost(this.name);

  setStrategy(Strategy strategy) {
    _strategy = strategy;
  }

  int make(int balance) {
    return _strategy.make(balance);
  }
}