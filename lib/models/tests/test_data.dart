class TestData {
  final int theoryId;
  final String text;
  final List<String> correctAnswers;
  final List<String> incorrectAnswers;

  TestData(
      {required this.theoryId,
      required this.text,
      required this.correctAnswers,
      required this.incorrectAnswers});

  factory TestData.fromJson(int theoryId, Map<Object?, dynamic> json) {
    return TestData(
      theoryId: theoryId,
      text: json['text'] as String,
      correctAnswers: json['correct_answers'].cast<String>(),
      incorrectAnswers: json['incorrect_answers'].cast<String>(),
    );
  }

  bool get multipleChoice => correctAnswers.length > 1;
}
