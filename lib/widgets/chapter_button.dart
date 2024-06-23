import 'package:flutter/material.dart';

class ChapterButton extends StatelessWidget {
  final ImageProvider image;
  final String title;
  final VoidCallback? onTap;

  const ChapterButton(
      {super.key,
      required this.image,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: 170,
              height: 170,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              )),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
              decoration: TextDecoration.none,
            ),
          )
        ],
      ),
    );
  }
}
