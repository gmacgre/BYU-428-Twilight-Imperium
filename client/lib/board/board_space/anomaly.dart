import 'package:client/data/strings.dart';
import 'package:client/data/system_data.dart';
import 'package:client/res/hover_tip.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnomalyWidget extends StatelessWidget {
  const AnomalyWidget({
    super.key,
    required this.anomaly,
    required this.diameter
  });
  final double diameter;
  final Anomaly anomaly;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: diameter,
        width: diameter,
        child: HoverTip(
          message: Strings.anomalyDisplayName[anomaly]!,
          child: CustomPaint(
            painter: switch(anomaly) {
              Anomaly.asteroid => _AsteroidPainter(),
              Anomaly.rift => _RiftPainter(),
              Anomaly.nebula => _NebulaPainter(),
              Anomaly.supernova => _SupernovaPainter(),
            },
          )
        ),
      ),
    );
  }
}

class _AsteroidPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint p = Paint()
      ..color = Colors.brown;
    
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.6), size.width * 0.1, p);

    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.75, size.height * 0.2), width: size.width * 0.15, height: size.height * 0.2), p);

    canvas.drawCircle(Offset(size.width * 0.87, size.height * 0.5), size.width * 0.13, p);

    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.6, size.height * 0.9), width: size.width * 0.3, height: size.height * 0.1), p);

    canvas.drawCircle(Offset(size.width * 0.15, size.height * 0.2), size.width * 0.05, p);
    canvas.drawCircle(Offset(size.width * 0.25, size.height * 0.25), size.width * 0.05, p);
    canvas.drawCircle(Offset(size.width * 0.13, size.height * 0.3), size.width * 0.05, p);

    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.6, size.height * 0.9), width: size.width * 0.3, height: size.height * 0.1), p);

    canvas.save();
    canvas.rotate(-0.78);
    canvas.drawOval(Rect.fromCenter(center: Offset(size.width * 0.05, size.height * 0.7), width: size.width * 0.25, height: size.height * 0.15), p);
    canvas.restore();

    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.7), size.width * 0.13, p);
    canvas.drawCircle(Offset(size.width * 0.25, size.height * 0.9), size.width * 0.08, p);
    canvas.drawCircle(Offset(size.width * 0.05, size.height * 0.5), size.width * 0.1, p);
    canvas.drawCircle(Offset(size.width * 0.55, size.height * 0.15), size.width * 0.11, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

class _RiftPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.33, Paint()..color = const Color.fromARGB(190, 142, 76, 154));
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.3, Paint()..color = Colors.white);


    Paint p = Paint()
      ..color = Colors.white;
    List<List<double>> conicPoints = [
      [size.width * 0.3, size.height * 0.1],
      [size.width * 0.2, size.height * 0.2],

      [size.width * 0.1, size.height * 0.3],
      [size.width * 0.2, size.height * 0.2],

      [size.width * 0.7, size.height * 0.9],
      [size.width * 0.8, size.height * 0.8],

      [size.width * 0.9, size.height * 0.7],
      [size.width * 0.8, size.height * 0.8],
      
    ];

    Path path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.5);
    for(int i = 0; i < conicPoints.length; i+=2) {
      path.conicTo(conicPoints[i][0], conicPoints[i][1], conicPoints[(i + 1) % conicPoints.length][0], conicPoints[(i + 1) % conicPoints.length][1], 1);
      path.conicTo(conicPoints[i][0], conicPoints[i][1], size.width * 0.5, size.height * 0.5, 0.8);
      path.conicTo(conicPoints[i][0], conicPoints[i][1], conicPoints[(i + 1) % conicPoints.length][0], conicPoints[(i + 1) % conicPoints.length][1], 3);
      path.conicTo(conicPoints[i][0], conicPoints[i][1], size.width * 0.5, size.height * 0.5, 2);
    }
    canvas.drawPath(path, p);

    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.27, Paint()..color = Colors.black38);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.25, Paint()..color = Colors.black87);
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

class _NebulaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    
    Paint p = Paint();


    p.color = const Color.fromARGB(200, 87, 235, 92);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.35, p);
    p.color = const Color.fromARGB(198, 175, 142, 76);
    // Outer "reaching" branches    
    Path path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.4);
    path.conicTo(size.width * 0.05, size.height * 0.53, 0.0, size.height * 0.47, 1);
    path.conicTo(size.width * 0.05, size.height * 0.53, size.width * 0.5, size.height * 0.6, 2);
    
    
    canvas.drawPath(path, p);

    path = Path();
    path.addArc(Rect.fromCenter(center: Offset(size.width * 0.75, size.height * 0.35), width: size.width * 0.4, height: size.height * 0.4), 0.0, -math.pi);
    path.addArc(Rect.fromCenter(center: Offset(size.width * 0.77, size.height * 0.35), width: size.width * 0.35, height: size.height * 0.3), math.pi, math.pi);

    path.addArc(Rect.fromCenter(center: Offset(size.width * 0.8, size.height * 0.6), width: size.width * 0.4, height: size.height * 0.4), (math.pi)/4, -math.pi);
    path.addArc(Rect.fromCenter(center: Offset(size.width * 0.83, size.height * 0.63), width: size.width * 0.3, height: size.height * 0.3), (5 * math.pi)/4, math.pi);
    
    canvas.drawPath(path, p);

    path = Path();
    path.moveTo(size.width * 0.4, size.height * 0.5);
    // path.lineTo(size.width * 0.2, size.height * 0.6);
    // path.lineTo(size.width * 0.6, size.height * 0.5);
    path.conicTo(size.width * 0.4, size.height * 0.9, size.width * 0.2, size.height * 0.9, 1);
    path.conicTo(size.width * 0.5, size.height * 0.9, size.width * 0.6, size.height * 0.5, 1);
    canvas.drawPath(path, p);

    p.color = const Color.fromARGB(200, 87, 235, 92);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.3, p);
    p.color = const Color.fromARGB(199, 70, 206, 239);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.25, p);
    p.color = const Color.fromARGB(199, 146, 17, 60);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.1, p);

    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

class _SupernovaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.45, Paint()..color = const Color.fromARGB(186, 175, 142, 52));
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.4, Paint()..color = const Color.fromARGB(186, 165, 88, 33));
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.35, Paint()..color = const Color.fromARGB(187, 165, 41, 33));
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.3, Paint()..color = const Color.fromARGB(186, 188, 77, 69));
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.25, Paint()..color = const Color.fromARGB(185, 209, 117, 111));
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.05, Paint()..color = const Color.fromARGB(184, 207, 164, 164));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}