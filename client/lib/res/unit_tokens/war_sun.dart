import 'dart:math';

import 'package:client/data/strings.dart';
import 'package:client/res/unit_tokens/unit.dart';
import 'package:flutter/material.dart';

class WarSunIcon extends StatelessWidget {
  const WarSunIcon({
    super.key,
    required this.outline,
    required this.fill,
    required this.combat,
    required this.move,
    required this.capacity,
    required this.cost,
    required this.width,
    required this.height
  });

  final double width;
  final double height;
  final Color fill;
  final Color outline;
  final int cost;
  final int move;
  final int combat;
  final int capacity;

  @override
  Widget build(BuildContext context) {
    return UnitIcon(
      width: width,
      height: height,
      cost: cost,
      combat: combat,
      move: move,
      capacity: capacity,
      painter: _WarSunPainter(fill, outline),
      tip: Strings.buildUnitDesc(Strings.warsun, cost, move, combat, capacity),
    );
  }
}

class _WarSunPainter extends CustomPainter {
  _WarSunPainter(this.fill, this.outline);

  final Color fill;
  final Color outline;
  
  @override
  void paint(Canvas canvas, Size size) {
    

    Paint paint = Paint();
    paint.color = fill;
     
    Path path = Path();
    
    path.addArc(
      Rect.fromCenter(
        center: Offset(
          size.width * 0.5,
          size.height * 0.5
        ),
        width: size.width, 
        height: size.height
      ), 
      (7 * pi) / 4, 
      -pi
    );

    path.addArc(
      Rect.fromCenter(
        center: Offset(
          size.width * 0.5,
          size.height * 0.5
        ),
        width: size.width, 
        height: size.height
      ), 
      (3 * pi) / 4, 
      -pi
    );
    
    canvas.drawPath(path, paint);


    paint.color = outline;
    paint.strokeWidth = 5.0;
    paint.style = PaintingStyle.stroke;

    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}