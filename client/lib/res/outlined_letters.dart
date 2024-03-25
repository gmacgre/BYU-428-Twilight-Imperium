import 'package:flutter/material.dart';

class OutlinedLetters extends StatelessWidget {
  const OutlinedLetters({super.key, required this.content, this.fontSize = 14.0});
  final String content;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          content,
          style: TextStyle(
            fontSize: fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 6.0
              ..color = Colors.black,
          ),
        ),
        Text(
        content,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white
          ),
        ),
      ]
    );
  }
}
