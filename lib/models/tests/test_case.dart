import 'package:collection/collection.dart';

import 'package:startup/models/tests/test_data.dart';

class TestCase {
  static Function eq = const ListEquality().equals;

  late final TestData _data;
  late final List<String> _answers = [];
  late final List<bool> _flags = [];

  TestCase(TestData data) {
    _data = data;
    List<(String, bool)> answersPair = [];
    for (var answer in data.correctAnswers) {
      answersPair.add((answer, true));
    }
    for (var answer in data.incorrectAnswers) {
      answersPair.add((answer, false));
    }
    answersPair.shuffle();
    for (var pair in answersPair) {
      _answers.add(pair.$1);
      _flags.add(pair.$2);
    }
  }

  bool get multipleChoice => _data.multipleChoice;

  String get text => _data.text;

  List<String> get answers => _answers;

  bool checkAnswer(List<bool> flags) {
    return eq(flags, _flags);
  }
}