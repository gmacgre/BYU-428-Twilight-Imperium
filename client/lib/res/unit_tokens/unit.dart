import 'package:client/res/hover_tip.dart';
import 'package:flutter/material.dart';

//Note: Don't use this class directly. Rather, use another class in the library that uses this class
class UnitIcon extends StatelessWidget {
  const UnitIcon({
    super.key,
    required this.width,
    required this.height,
    required this.cost,
    required this.move,
    required this.combat,
    required this.capacity,
    required this.painter,
    required this.tip
  });
  
  final double width;
  final double height;
  final int cost;
  final int move;
  final int combat;
  final int capacity;
  final CustomPainter painter;
  final String tip;

  @override
  Widget build(BuildContext context) {
    return HoverTip(
      message: tip,
      child: SizedBox(
        width: width,
        height: height,
        child: CustomPaint(
            painter: painter,
        ),
      )
    );
  }
}