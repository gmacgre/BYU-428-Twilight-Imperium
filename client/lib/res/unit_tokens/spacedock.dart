import 'package:client/data/color_data.dart';
import 'package:flutter/material.dart';

class SpacedockIcon extends StatelessWidget {
  const SpacedockIcon({
    super.key,
    required this.color
  });

  final Color color;


  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _SpacedockPainter(color),);
  }
}

class _SpacedockPainter extends CustomPainter {
  _SpacedockPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    
    Paint paint = Paint();
    Color negativeColor = (color == ColorData.playerColor[5])? Colors.white : Colors.black;
    paint.color = negativeColor;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.5, paint);
    paint.color = color;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.4, paint);

    paint.color = negativeColor;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.3, paint);
    
    paint.color = color;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.15, paint);

    List<List<double>> pathCoords = [
      [size.width * 0.5, size.height * 0.566], // Center Triangle
      [size.width * 0.25, size.height * 0.75],
      [size.width * 0.2, size.height * 0.65],
      [size.width * 0.45, size.height * 0.467], // Center Triangle
      [size.width * 0.45, size.height * 0.15],
      [size.width * 0.55, size.height * 0.15],
      [size.width * 0.55, size.height * 0.467], // Center Triangle
      [size.width * 0.8, size.height * 0.65],
      [size.width * 0.75, size.height * 0.75],
    ];
    Path p = Path();
    p.moveTo(pathCoords[0][0], pathCoords[0][1]);
    for(List<double> v in pathCoords) {
      p.lineTo(v[0], v[1]);
    }
    p.lineTo(pathCoords[0][0], pathCoords[0][1]);

    canvas.drawPath(p, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}