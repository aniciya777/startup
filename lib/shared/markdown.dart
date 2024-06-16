import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class StaticMarkdown {
  static const TextStyle _style = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
  );

  static MarkdownStyleSheet getStyle() {
    return MarkdownStyleSheet(
      p: _style,
      listBullet: _style,
      h5: _style.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      h5Align: WrapAlignment.center,
    );
  }
}
