import 'package:client/data/strings.dart';
import 'package:client/res/unit_tokens/unit.dart';
import 'package:flutter/material.dart';

class DestroyerIcon extends StatelessWidget {
  const DestroyerIcon({
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
      painter: _DestroyerPainter(fill, outline),
      tip: Strings.buildUnitDesc(Strings.destroyer, cost, move, combat, capacity),
    );
  }
}

class _DestroyerPainter extends CustomPainter {
  _DestroyerPainter(this.fill, this.outline);

  final Color fill;
  final Color outline;
  
  @override
  void paint(Canvas canvas, Size size) {
    List<List<double>> points = [
      [0.0, size.height * 0.35],
      [0.0, size.height * 0.40],
      [size.width * 0.05, size.height * 0.40],
      [size.width * 0.05, size.height * 0.60],
      [0.0, size.height * 0.60],
      [0.0, size.height * 0.65],
      [size.width * 0.15, size.height * 0.65],
      [size.width * 0.25, size.height * 0.95],
      [size.width * 0.30, size.height],
      [size.width * 0.55, size.height],
      [size.width * 0.55, size.height * 0.95],
      [size.width * 0.45, size.height * 0.75],
      [size.width * 0.60, size.height * 0.80],
      [size.width * 0.90, size.height * 0.65],
      [size.width, size.height * 0.5],
      [size.width * 0.90, size.height * 0.35],
      [size.width * 0.60, size.height * 0.20],
      [size.width * 0.45, size.height * 0.25],
      [size.width * 0.55, size.height * 0.05],
      [size.width * 0.55, 0.0],
      [size.width * 0.30, 0.0],
      [size.width * 0.25, size.height * 0.05],
      [size.width * 0.15, size.height * 0.35],
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