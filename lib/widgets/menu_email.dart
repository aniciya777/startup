import 'package:flutter/cupertino.dart';

import 'menu_input.dart';

class MenuEmail extends MenuInput {
  MenuEmail({super.key, required super.label, super.hasNext, super.errorStream});

  @override
  StateMenuEmail createState() => StateMenuEmail();
}

class StateMenuEmail extends StateMenuInput {
  @override
  TextInputType get keyboardType => TextInputType.emailAddress;
}