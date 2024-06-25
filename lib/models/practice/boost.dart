import 'package:startup/models/practice/strategies/_abstract_strategy.dart';
import 'package:startup/models/practice/strategies/empty_strategy.dart';

class Boost {
  final String name;
  Strategy _strategy = EmptyStrategy();
  bool _enabled = true;

  Boost(this.name);

  bool get enabled => _enabled;

  setStrategy(Strategy strategy) {
    _strategy = strategy;
  }

  int make(int balance) {
    if (!_enabled) {
      throw Exception('Boost is not enabled');
    }
    _enabled = false;
    return _strategy.make(balance);
  }
}