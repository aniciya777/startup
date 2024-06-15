import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/theory/theory.dart';

class TheoryButton extends StatelessWidget {
  final Theory theory;

  const TheoryButton({super.key, required this.theory});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.none,
              height: 2,
            ),
            children: [
              TextSpan(
                text: "${theory.id}. ",
              ),
              TextSpan(
                text: theory.title,
                style: const TextStyle(decoration: TextDecoration.underline),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onTap() {

  }
}
