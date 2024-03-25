import 'package:client/data/strings.dart';
import 'package:client/res/unit_tokens/unit.dart';
import 'package:flutter/material.dart';

class FighterIcon extends StatelessWidget {
  const FighterIcon({
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
      painter: _FighterPainter(fill, outline),
      tip: Strings.buildUnitDesc(Strings.fighter, cost, move, combat, capacity),
    );
  }
}

class _FighterPainter extends CustomPainter {
  _FighterPainter(this.fill, this.outline);

  final Color fill;
  final Color outline;
  
  @override
  void paint(Canvas canvas, Size size) {
    List<List<double>> points = [
      [size.width * 0.05, size.height * 0.05],
      [size.width * 0.20, size.height * 0.15],
      [size.width * 0.35, size.height * 0.15],
      [size.width * 0.45, size.height * 0.40],
      [size.width * 0.15, size.height * 0.40],
      [size.width * 0.05, size.height * 0.50],
      [size.width * 0.15, size.height * 0.60],
      [size.width * 0.45, size.height * 0.60],
      [size.width * 0.35, size.height * 0.85],
      [size.width * 0.20, size.height * 0.85],
      [size.width * 0.05, size.height * 0.95],
      [size.width * 0.85, size.height * 0.95],
      [size.width * 0.85, size.height * 0.85],
      [size.width * 0.55, size.height * 0.85],
      [size.width * 0.65, size.height * 0.60],
      [size.width * 0.90, size.height * 0.55],
      [size.width, size.height * 0.5],
      [size.width * 0.90, size.height * 0.45],
      [size.width * 0.65, size.height * 0.40],
      [size.width * 0.55, size.height * 0.15],
      [size.width * 0.85, size.height * 0.15],
      [size.width * 0.85, size.height * 0.05],
    ];


    Paint paint = Paint();
    paint.color = fill;
     
    Path path = Path();
    path.moveTo(points[0][0], points[0][1]);
    for(int i = 0; i < points.length; i++) {
      path.lineTo(points[i % points.length][0], points[i % points.length][1]);
    }
    path.lineTo(points[0][0], points[0][1]);
    path.lineTo(points[1][0], points[1][1]);
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