import 'package:client/data/color_data.dart';
import 'package:client/pages/game/info/objective_view.dart';
import 'package:client/pages/game/info/strategy_card.dart';
import 'package:client/res/hover_tip.dart';
import 'package:client/res/outlined_letters.dart';
import 'package:client/data/strings.dart';
import 'package:flutter/material.dart';

class PlayerOverview extends StatelessWidget {
  const PlayerOverview({
    super.key,
    this.race = "",
    this.strategyCardId = -1,
    this.tacticTokenCount = -1,
    this.fleetTokenCount = -1,
    this.strategyTokenCount = -1,
    this.victoryPoints = -1,
    this.playerColor = 6
  });

  final String race;
  final int strategyCardId;
  final int tacticTokenCount;
  final int fleetTokenCount;
  final int strategyTokenCount;
  final int victoryPoints;
  final int playerColor;
  


  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ColorData.playerColor[playerColor]
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
          children: _buildRow()
        ),
      );
  }

  List<Widget> _buildRow() {
    List<Widget> innerItems = [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          height: 60,
          width: 60,
          child: Image.asset(_getIcon(race), fit: BoxFit.fitWidth)
          ),
      ),
      StrategyCard(
        strategyCardId: strategyCardId,
        cardWidth: 30.0,
        cardHeight: 50.0,
      ),
      HoverTip(
        message: Strings.victoryPoints,
        child: ObjectiveView(
         child: OutlinedLetters(content: '$victoryPoints') 
        )
      ),
      _PoolCount(Strings.tactic, tacticTokenCount, '${Strings.tacticTokenDesc}\n${Strings.tokenCount(tacticTokenCount, Strings.tactic)}'),
      _PoolCount(Strings.fleet, fleetTokenCount, '${Strings.fleetTokenDesc}\n${Strings.tokenCount(fleetTokenCount, Strings.fleet)}'),
      _PoolCount(Strings.strategy, strategyTokenCount, '${Strings.strategyTokenDesc}\n${Strings.tokenCount(strategyTokenCount, Strings.strategy)}')
    ];
    
    return innerItems.map((e) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: e
      )).toList();
  }

  String _getIcon(String race) {
    if(race == Strings.noSelectedRace) return Strings.agendaIcon;
    return Strings.raceIcon(race);
  }
}

class _PoolCount extends StatelessWidget {
  const _PoolCount(this.title, this.count, this.desc);

  final String desc;
  final int count;
  final String title;
  @override
  Widget build(BuildContext context) {
    return HoverTip(
      message: desc,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 2.0),
            child: OutlinedLetters(content: title),
          ),
          CustomPaint(
            size: const Size(35.0, 35.0),
            painter: _TrianglePainter(),
            child: SizedBox(
              width: 35.0,
              height: 35.0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(35.0 * 0.40, 35.0 * 0.10, 0.0, 0.0),
                child: OutlinedLetters(content: '$count')
              ),
            ),
          ),
        ],
      ),
    );
  }
}



/*

This class paints a grey triangle to be filled with a child of size s.
It uses 3 points to draw a path that is filled. The color is grey, and this is not mutable.
It also draws a border in white to make sure it stands out against any colored background.
A-------C
 \     /
  \   /
   \ /
    B
*/
class _TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    List<List<double>> points = [
      [0.0           , 0.0      ],
      [s.width * 0.50, s.height ],
      [s.width       , 0.0      ]
    ];
    Paint paint = Paint();
    paint.color = Colors.blueGrey;
    Path path = Path();
    for(int i = 0; i < points.length + 1; i++) {
      path.lineTo(points[i % points.length][0], points[i % points.length][1]);
    }
    c.drawPath(path, paint);
    paint.color = Colors.white;
    paint.strokeWidth = 2.0;
    paint.style = PaintingStyle.stroke;
    c.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}