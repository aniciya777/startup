import 'package:startup/shared/colors.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const MenuButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: ShapeDecoration(
          color: StaticColors.button,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              decoration: TextDecoration.none,
              color: StaticColors.buttonText,
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }
}
