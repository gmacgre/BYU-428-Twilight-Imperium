import 'package:flutter/material.dart';

class HoverTip extends StatelessWidget {
  const HoverTip({
    super.key,
    required this.child,
    this.message = ''
  });

  final Widget child;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      textStyle: const TextStyle(
        fontFamily: 'Handel Gothic D',
        color: Colors.white,
      ),
      child: child,
    );
  }
}