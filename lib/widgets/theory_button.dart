import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../models/theory/theory.dart';
import '../screens/theory.dart';

class TheoryButton extends StatelessWidget {
  final Theory theory;
  late BuildContext _context;

  TheoryButton({super.key, required this.theory});

  @override
  Widget build(BuildContext context) {
    _context = context;
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
    Navigator.push(
        _context,
        PageTransition(
          alignment: Alignment.center,
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 250),
          child: TheoryScreen(theory),
        ));
  }
}
