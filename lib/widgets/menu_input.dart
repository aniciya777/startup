import 'package:startup/shared/colors.dart';
import 'package:flutter/material.dart';

class MenuInput extends StatefulWidget {
  final String label;
  final bool? hasNext;
  final _myController = TextEditingController();
  final Stream<String?> errorStream;

  MenuInput({
    super.key,
    required this.label,
    this.hasNext,
    this.errorStream = const Stream.empty(),
  });

  @override
  State<MenuInput> createState() => StateMenuInput();

  TextEditingController get controller => _myController;

  String get value => _myController.text;
}

class StateMenuInput extends State<MenuInput> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      borderOnForeground: false,
      child: StreamBuilder<String?>(
        stream: widget.errorStream,
        builder: (context, snapshot) {
          return TextField(
            controller: widget._myController,
            style: const TextStyle(
                color: StaticColors.buttonText,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0),
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: widget.label,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.5, horizontal: 20),
              suffixIcon: suffixIcon,
              suffixIconColor: StaticColors.buttonText,
              errorText: snapshot.data,
              errorStyle: const TextStyle(
                color: StaticColors.errorText,
                fontSize: 20,
              ),
            ),
            textInputAction:
                (widget.hasNext ?? false) ? TextInputAction.next : TextInputAction.done,
            obscureText: obscureText,
            keyboardType: keyboardType,
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    widget._myController.dispose();
    super.dispose();
  }

  Widget? get suffixIcon => null;

  bool get obscureText => false;

  TextInputType get keyboardType => TextInputType.text;
}
