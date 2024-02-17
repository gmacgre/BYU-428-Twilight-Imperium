import 'package:client/outlined_letters.dart';
import 'package:flutter/material.dart';
import 'package:client/info/strategy_card.dart';

class PlayerOverview extends StatelessWidget {
  const PlayerOverview({
    super.key,
    this.icon = "",
    this.strategyCardId = -1,
    this.tacticTokenCount = -1,
    this.fleetTokenCount = -1,
    this.strategyTokenCount = -1,
    this.objScoredCount = -1
  });

  final String icon;
  final int strategyCardId;
  final int tacticTokenCount;
  final int fleetTokenCount;
  final int strategyTokenCount;
  final int objScoredCount;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
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
          child: Image.asset(icon, fit: BoxFit.fitWidth)
          ),
      ),
      StrategyCard(
        strategyCardId: strategyCardId,
        cardWidth: 30.0,
        cardHeight: 50.0,
      ),
      DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.amberAccent,
          border: Border.all(
            color: Colors.black,
            width: 2.0
            )
        ),
        
        //Agendas Scored    
        child: SizedBox(
          width: 30.0,
          height: 50.0,
          child: Center(
            child: OutlinedLetters(content: '$objScoredCount')
          )
        ),
      ),
      _PoolCount("Tactic", tacticTokenCount),
      _PoolCount("Fleet", fleetTokenCount),
      _PoolCount("Strategy", strategyTokenCount)
    ];
    List<Widget> toReturn = [];

    for(int i = 0; i < innerItems.length; i++) {
      toReturn.add(Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: innerItems[i]
      ));
    }
    
    return toReturn;
  }
}

class _PoolCount extends StatelessWidget {
  const _PoolCount(this.desc, this.count);

  final String desc;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(desc, 
          style: const TextStyle(
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold
          ),
        ),
        Text("$count", 
          style: const TextStyle(
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}