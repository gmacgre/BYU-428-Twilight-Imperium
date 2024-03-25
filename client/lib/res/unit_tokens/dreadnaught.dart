import 'package:client/data/strings.dart';
import 'package:client/res/unit_tokens/unit.dart';
import 'package:flutter/material.dart';
/*
  This is the widget for a dreadnaught icon.
  This uses the canvas.drawLine() to build the outline in a provided color, and then fills said outline in a provided color.
  The rough pattern is as such:


    M   L
                    I
  A       K       J

                                            H

  B       E       F
                    G
    C   D

  While any given x and y dimensions can be provided, it is assumed that a 2 x 1 ratio is kept (double width)
*/
class DreadnaughtIcon extends StatelessWidget {
  const DreadnaughtIcon({
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
      painter: _DreadnaughtPainter(fill, outline),
      tip: Strings.buildUnitDesc(Strings.dreadnaught, cost, move, combat, capacity),
    );
  }
}

class _DreadnaughtPainter extends CustomPainter {
  _DreadnaughtPainter(this.fill, this.outline);

  final Color fill;
  final Color outline;
  @override
  void paint(Canvas canvas, Size size) {
    List<List<double>> points = [
      [0.0, size.height * 0.33],
      [0.0, size.height * 0.66],
      [size.width * 0.05, size.height],
      [size.width * 0.15, size.height],
      [size.width * 0.25, size.height * 0.75],
      [size.width * 0.45, size.height * 0.75],
      [size.width * 0.50, size.height * 0.90],  // Start the Curve
      [size.width, size.height * 0.5], 
      [size.width * 0.50, size.height * 0.10],  // Last curve point
      [size.width * 0.45, size.height * 0.25],
      [size.width * 0.25, size.height * 0.25],
      [size.width * 0.15, 0.0],
      [size.width * 0.05, 0.0],
    ];

    List<List<double>> conicPoints = [
      [size.width * 0.75, size.height * 0.90],
      [size.width * 0.75, size.height * 0.10]
    ];

    Paint paint = Paint();
    paint.color = fill;
     
    Path path = Path();
    path.moveTo(points[0][0], points[0][1]);
    for(int i = 0; i < points.length; i++) {
      if(i > 6 && i < 9) {
        path.conicTo(conicPoints[i-7][0], conicPoints[i-7][1], points[i][0], points[i][1], 0.5);
      }
      else {
        path.lineTo(points[i % points.length][0], points[i % points.length][1]);
      }
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