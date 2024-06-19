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

  static List<String> get placeholders {
    return [
      'Сформулируйте основную идею проекта, ключевые цели\nи ожидаемые результаты кратко и привлекательно',
      'Четко определите основную цель проекта и конкретные задачи,\nкоторые необходимо выполнить для её достижения',
      'Проведите исследование рынка, определите целевую аудиторию\nи оцените конкуренцию в выбранной нише',
      'Опишите текущий статус проекта, его команду и ресурсы,\nнеобходимые для реализации',
      'Детально опишите ваш продукт или услугу, подчеркивая\nих уникальные особенности и преимущества для клиентов',
      'Идентифицируйте основные риски проекта\nи предложите стратегии их минимизации'
    ];
  }

  static List<InlineSpan?> get spans {
    return [
      TextSpan(
          children: [
            TextSpan(
                text: 'Идею можно подсмотреть на ', style: SchemePlan.textStyle
            ),
            TextSpan(
              text: 'YouTube',
              style: SchemePlan.textStyle.copyWith(
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {
                launchUrl(
                    Uri.parse('https://www.youtube.com/results?search_query=готовые+бизнес+идеи')
                );
              },
            ),
          ]
      ),
      TextSpan(text: 'Не вписывайте невыполнимые задачи', style: SchemePlan.textStyle),
      TextSpan(
        children: [
          TextSpan(
            text: 'Используйте ', style: SchemePlan.textStyle
          ),
          TextSpan(
            text: 'Yandex Wordstat',
            style: SchemePlan.textStyle.copyWith(
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {
              launchUrl(
                  Uri.parse('https://wordstat.yandex.ru/')
              );
            },
          ),
          TextSpan(
              text: ' и ', style: SchemePlan.textStyle
          ),
          TextSpan(
            text: 'Google Trends',
            style: SchemePlan.textStyle.copyWith(
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = () {
              launchUrl(
                  Uri.parse('https://trends.google.ru/trends/')
              );
            },
          ),
        ]
      ),
      TextSpan(text: 'Обязательно расскажите что у вас уже есть', style: SchemePlan.textStyle),
      TextSpan(text: 'Опишите так, чтобы любой понял суть проекта', style: SchemePlan.textStyle),
      TextSpan(
          children: [
            TextSpan(
              text: 'RiskWatch',
              style: SchemePlan.textStyle.copyWith(
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {
                launchUrl(
                    Uri.parse('https://www.riskwatch.com/')
                );
              },
            ),
            TextSpan(
                text: ' поможет оценивать риски', style: SchemePlan.textStyle
            ),
          ]
      ),
    ];
  }

  static int get length {
    assert(keys.length == labels.length);
    assert(keys.length == spans.length);
    assert(keys.length == placeholders.length);
    return keys.length;
  }
}