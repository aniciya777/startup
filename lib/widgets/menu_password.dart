import 'package:startup/widgets/menu_input.dart';
import 'package:flutter/material.dart';

class MenuPassword extends MenuInput {
  MenuPassword({super.key, required super.label, super.hasNext, super.errorStream});

  @override
  StateMenuPassword createState() => StateMenuPassword();
}

class StateMenuPassword extends StateMenuInput {
  bool _obscured = true;

  @override
  Widget? get suffixIcon {
    if (obscureText) {
      return IconButton(
        icon: const Icon(Icons.visibility),
        onPressed: toggleObscureText,
      );
    } else {
      return IconButton(
        icon: const Icon(Icons.visibility_off),
        onPressed: toggleObscureText,
      );
    }
  }

  toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  bool get obscureText => _obscured;
  set obscureText(bool value) => _obscured = value;
}