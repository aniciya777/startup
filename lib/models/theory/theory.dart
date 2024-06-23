import 'dart:async';

import 'package:startup/models/tests/test_case.dart';
import 'package:startup/models/tests/test_data.dart';

import '../tests/test_status.dart';

class Theory {
  final int id;
  final String title;
  final String text;
  bool visited = false;
  TestStatus _status = TestStatus.none;
  final List<TestData> _tests = [];
  StreamController<TestStatus> statusStream = StreamController<TestStatus>.broadcast();

  Theory(this.id, this.title, this.text) {
    statusStream.add(TestStatus.none);
  }

  factory Theory.fromJson(Map<Object?, dynamic> json) {
    var instance = Theory(json['id'], json['name'], json['text']);
    if (json.containsKey('tests')) {
      for (var element in (json['tests'] as List<dynamic>)) {
        instance._tests.add(TestData.fromJson(instance.id, element));
      }
      instance.status = TestStatus.unvisited;
    }
    return instance;
  }

  TestStatus get status => _status;

  set status(TestStatus status) {
    _status = status;
    statusStream.add(status);
  }

  int get testsCount => _tests.length;

  TestCase getCase(int index) {
    return TestCase(_tests[index]);
  }
}