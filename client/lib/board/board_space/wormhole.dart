import 'package:client/data/strings.dart';
import 'package:client/data/system_data.dart';
import 'package:client/res/hover_tip.dart';
import 'package:client/res/outlined_letters.dart';
import 'package:flutter/material.dart';

class WormholeWidget extends StatelessWidget {
  const WormholeWidget({
    super.key,
    required this.wormhole,
    required this.diameter
  });
  final Wormhole wormhole;
  final double diameter;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: diameter,
        height: diameter,
        child: HoverTip(
          message: Strings.wormholeDisplayName[wormhole]!,
          child: SizedBox(
            width: diameter,
            height: diameter,
            child: CustomPaint(
              painter: _WormholePainter(wormhole: wormhole, color: _getColor()),
              child: Center(
                child: OutlinedLetters(
                  content: switch (wormhole) {
                    Wormhole.alpha => 'α',
                    Wormhole.beta => 'β',
                    Wormhole.gamma => 'γ'
                  }
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    return switch (wormhole) {
      Wormhole.alpha => const Color.fromARGB(200, 255, 179, 66),
      Wormhole.beta => const Color.fromARGB(200, 92, 212, 71),
      Wormhole.gamma => const Color.fromARGB(200, 233, 102, 145)
    };
  }
}

class _WormholePainter extends CustomPainter {
  Wormhole wormhole;
  Color color;
  _WormholePainter({
    required this.wormhole,
    required this.color
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint p = Paint()
      ..color = color;
    List<List<double>> conicPoints = [
      [size.width * 0.15, size.height * 0.15],
      [size.width * 0.5, 0.0],
      [size.width * 0.85, size.height * 0.15],
      [size.width, size.height * 0.5],
      [size.width * 0.85, size.height * 0.85],
      [size.width * 0.5, size.height],
      [size.width * 0.15, size.height * 0.85],
      [0.0, size.height * 0.5],
      
    ];

    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.33, p);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), size.width * 0.4, p);
    Path path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.5);
    for(int i = 0; i < conicPoints.length; i++) {
      path.conicTo(conicPoints[i][0], conicPoints[i][1], conicPoints[(i + 1) % conicPoints.length][0], conicPoints[(i + 1) % conicPoints.length][1], 5);
      path.conicTo(conicPoints[i][0], conicPoints[i][1], size.width * 0.5, size.height * 0.5, 0.5);
    }
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}
