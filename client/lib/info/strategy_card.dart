import 'package:client/res/hover_tip.dart';
import 'package:client/res/outlined_letters.dart';
import 'package:client/data/strings.dart';
import 'package:flutter/material.dart';

/*
    This is a widget for drawing the strategy card.
     that uses canvas.drawLine() to build an outline of a card, starting near the origin and going clockwise as shown:
     F-----------------------E
    A                         \
    |                          \
    |                           D
    |                           /
    |                          /
    |                         /
    |                        /
    |                       /
    |                      /
    |                     /
    |                    /
    |                   /
    |                  /
    B-----------------C

    Details of the percentages on the canvas are as follows from the origin at the top left corner (% width diff, % height diff)):
    A: (0, 5)
    B: (0, 100)
    C: (70, 100)
    D: (100, 30)
    E: (80, 0)
    F: (5, 0)
*/

class StrategyCard extends StatelessWidget {
  const StrategyCard({
    super.key,
    this.strategyCardId = -1,
    this.cardWidth = 0,
    this.cardHeight = 0,
  });

  final int strategyCardId;
  final double cardWidth;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    return HoverTip(
      message: _getCardDesc(strategyCardId),
      child: CustomPaint(
        size: Size(cardWidth, cardHeight),
        painter: _StrategyCardPainter(_getCardColor(strategyCardId)),
        child: SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: Padding(
            padding: EdgeInsets.fromLTRB(cardWidth * 0.30, cardHeight * 0.30, 0.0, 0.0),
            child: OutlinedLetters(content: '$strategyCardId')
          )
        )
      ),
    );
  }

  Color _getCardColor(int id) {
    const List<Color> cardColors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.cyan,
      Colors.blue,
      Colors.indigo,
      Colors.purple
    ];
    if(id - 1 < 0 || id - 1 > 7) return Colors.black;
    return cardColors[id-1];
  }

  String _getCardDesc(int id) {
    if(id < 0 || id > 8) return Strings.invalidStrategyCard;
    return Strings.strategyCardPowerDescription[id];
  }
}

class _StrategyCardPainter extends CustomPainter {

  _StrategyCardPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {    
    List<List<double>> points = [
      [0.0              , size.height * 0.10],
      [0.0              , size.height       ],
      [size.width * 0.60, size.height       ],
      [size.width       , size.height * 0.15],
      [size.width * 0.85, 0.0               ],
      [size.width * 0.10, 0.0               ]
    ];

    Paint paint = Paint();
    paint.color = color;

    Path path = Path();
    path.moveTo(points[0][0], points[0][1]);
    for(int i = 0; i < points.length + 1; i++) {
      path.lineTo(points[i % points.length][0], points[i % points.length][1]);
    }
    canvas.drawPath(path, paint);
    paint.color = Colors.black;
    paint.strokeWidth = 2.0;
    paint.style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}