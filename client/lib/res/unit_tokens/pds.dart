import 'package:client/data/color_data.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class PDSIcon extends StatelessWidget {
  const PDSIcon({
    required this.color,
    required this.count,
    super.key
  });
  final Color color;
  final int count;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PDSPainter(color: color),
    );
  }
}

class _PDSPainter extends CustomPainter {
  _PDSPainter({
    required this.color
  });
  Color color;
  
  @override
  void paint(Canvas canvas, Size size) {
    Path p = Path();
    Color outline = (color == ColorData.playerColor[5]) ? Colors.white : Colors.black;
    Paint outlinePaint = Paint()
      ..color = outline
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    Paint mainPaint = Paint()..color = color;

    p.moveTo(size.width * 0.05, size.height);
    p.lineTo(size.width * 0.95, size.height);
    p.arcTo(Rect.fromCircle(center: Offset(size.width * 0.5, size.height), radius: size.width * 0.45), 0, -math.pi, false);
    p.lineTo(size.width * 0.5, size.height);

    

    canvas.drawPath(p, outlinePaint);
    canvas.drawPath(p, mainPaint);

    p = Path();
    Rect center = Rect.fromCircle(center: Offset(size.width * 0.5, size.height * 0.7), radius: size.width * 0.1);
    p.arcTo(center, math.pi / 4, math.pi, false);
    p.lineTo(size.width * 0.8, size.height * 0.4);
    p.lineTo(size.width * 0.88, size.height * 0.5);
    p.arcTo(center, math.pi / 4, 0.0, false);


    canvas.drawPath(p, outlinePaint);
    canvas.drawPath(p, mainPaint);    
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }  
}