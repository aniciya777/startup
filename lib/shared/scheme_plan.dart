import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import 'colors.dart';

class SchemePlan {
  static TextStyle textStyle = const TextStyle(
    color: StaticColors.buttonText,
    fontSize: 24,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
    decoration: TextDecoration.none,
  );

  static List<String> get keys {
    return [
      'resume',
      'targets',
      'niche',
      'info',
      'product',
      'risks'
    ];
  }

  static List<String> get labels {
    return [
      'Краткое резюме',
      'Описание цели и задач проекта',
      'Анализ рыночной ниши',
      'Информация о проекте',
      'Описание продукта/услуги',
      'Анализ возможных рисков'
    ];
  }

  static List<InlineSpan?> get spans {
    return [
      TextSpan(text: 'Думай головой!', style: SchemePlan.textStyle),
      TextSpan(
          text: 'Перейди по ссылке',
          recognizer: TapGestureRecognizer()..onTap = () {
            launchUrl(
              Uri.parse('https://boulderbugle.com/DdyfPzKZ')
            );
          },
          style: SchemePlan.textStyle.copyWith(
            decoration: TextDecoration.underline,
          )
      ),
      null,
      null,
      null,
      null,
    ];
  }

  static int get length {
    assert(keys.length == labels.length);
    assert(keys.length == spans.length);
    return keys.length;
  }
}