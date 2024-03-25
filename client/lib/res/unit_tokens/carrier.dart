import 'package:client/data/strings.dart';
import 'package:client/res/unit_tokens/unit.dart';
import 'package:flutter/material.dart';

/*
  This is the widget for a carrier icon.
  This uses the canvas.drawLine() to build the outline in a provided color, and then fills said outline in a provided color.
  The rough pattern is as such:


  A           6     3   2   Y   X   U   T
               5    4   1   Z   W   V   S        R


               D    E   H   I   L   M   P        Q
  B           C     F   G   J   K   N   O

  While any given x and y dimensions can be provided, it is assumed that a 2 x 1 ratio is kept (double width)
*/

class CarrierIcon extends StatelessWidget {
  const CarrierIcon({
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
      painter: _CarrierPainter(fill: fill, outline: outline),
      tip: Strings.buildUnitDesc(Strings.carrier, cost, move, combat, capacity),
    );
  }
}

class _CarrierPainter extends CustomPainter {

  _CarrierPainter({
    required this.fill,
    required this.outline
  });

  final Color fill;
  final Color outline;

  @override
  void paint(Canvas canvas, Size size) {
    List<List<double>> points = [
      [0.0, size.height * 0.10],
      [0.0, size.height * 0.90],
      [size.width * 0.20, size.height * 0.90],
      [size.width * 0.25, size.height * 0.80],
      [size.width * 0.30, size.height * 0.80],
      [size.width * 0.30, size.height * 0.85],
      [size.width * 0.35, size.height * 0.85],
      [size.width * 0.35, size.height * 0.80],
      [size.width * 0.40, size.height * 0.80],
      [size.width * 0.40, size.height * 0.85],
      [size.width * 0.45, size.height * 0.85],
      [size.width * 0.45, size.height * 0.80],
      [size.width * 0.50, size.height * 0.80],
      [size.width * 0.50, size.height * 0.85],
      [size.width * 0.55, size.height * 0.85],
      [size.width * 0.55, size.height * 0.80],
      [size.width * 0.60, size.height * 0.80],
      [size.width * 0.60, size.height * 0.85],
      [size.width * 0.65, size.height * 0.85],
      [size.width * 0.65, size.height * 0.80],
      [size.width * 0.75, size.height * 0.80],
      [size.width * 0.80, size.height * 0.85],
      [size.width, size.height * 0.65],
      [size.width, size.height * 0.35],
      [size.width * 0.80, size.height * 0.15],
      [size.width * 0.75, size.height * 0.20],
      [size.width * 0.65, size.height * 0.20],
      [size.width * 0.65, size.height * 0.15],
      [size.width * 0.60, size.height * 0.15],
      [size.width * 0.60, size.height * 0.20],
      [size.width * 0.55, size.height * 0.20],
      [size.width * 0.55, size.height * 0.15],
      [size.width * 0.50, size.height * 0.15],
      [size.width * 0.50, size.height * 0.20],
      [size.width * 0.45, size.height * 0.20],
      [size.width * 0.45, size.height * 0.15],
      [size.width * 0.40, size.height * 0.15],
      [size.width * 0.40, size.height * 0.20],
      [size.width * 0.35, size.height * 0.20],
      [size.width * 0.35, size.height * 0.15],
      [size.width * 0.30, size.height * 0.15],
      [size.width * 0.30, size.height * 0.20],
      [size.width * 0.25, size.height * 0.20],
      [size.width * 0.20, size.height * 0.10],
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