import 'package:client/info/objective_view.dart';
import 'package:client/info/presenter/global_info_presenter.dart';
import 'package:client/info/player_overview.dart';
import 'package:client/info/strategy_card.dart';
import 'package:client/model/objective.dart';
import 'package:client/res/hover_tip.dart';
import 'package:client/res/outlined_letters.dart';
import 'package:client/res/strings.dart';
import 'package:flutter/material.dart';

class GlobalInfo extends StatefulWidget {
  const GlobalInfo({super.key});

  @override
  State<GlobalInfo> createState() => _GlobalInfoState();
}

class _GlobalInfoState extends State<GlobalInfo> {

  late GlobalInfoPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = GlobalInfoPresenter();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.blueGrey),
      child: ListView(
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    //Build n player overview Widgets
    //One non-player info Widget
    List<Widget> toReturn = [];

    for(int i = 0; i < _presenter.getNumPlayers(); i++) {
      toReturn.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
          child: PlayerOverview(
            icon: _presenter.getIcon(i),
            strategyCardId: _presenter.getStrategyCard(i),
            tacticTokenCount: _presenter.getTacticPool(i),
            fleetTokenCount: _presenter.getFleetPool(i),
            strategyTokenCount: _presenter.getStrategyPool(i),
            victoryPoints: _presenter.getVictoryPoints(i),
            playerColor: i,
          )
        )
      );
    }
    //Divider between Player Overviews and generic global info
    toReturn.add(
      const DecoratedBox(
        decoration: BoxDecoration(
        color: Colors.amber,
        ),
        child: SizedBox(
          height: 5.0,
        )
      )
    );
    //Untaken Strategy Cards
    toReturn.add(
      Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 5.0),
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Colors.black54),
          child: Row(
            children: _buildUntakenRow(),
          ),
        ),
      )
    );

    toReturn.add(
      Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 10.0),
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Colors.black54),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: _getPublicObjectives(),
            ),
          ),
        ),
      )
    );

    return toReturn;
  }

  List<Widget> _buildUntakenRow() {
    List<Widget> toReturn = [
      const SizedBox(
        width: 0.0,
        height: 70.0,
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: HoverTip(
          message: Strings.strategyCardDesc,
          child: OutlinedLetters(
            content: Strings.untakenStrategyCards
          ),
        ),
      ),
    ];
    List<int> untaken = _presenter.getUntakenStrategyCards();
    for(int id in untaken) {
      toReturn.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: StrategyCard(
            strategyCardId: id,
            cardHeight: 50.0,
            cardWidth: 30.0,
          ),
        )
      );
    }

    return toReturn;
  }

  List<Widget> _getPublicObjectives() {

    //Title for section
    List<Widget> toReturn = [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: HoverTip(
          message: Strings.publicObjectiveDesc,
          child: OutlinedLetters(content: Strings.publicObjectives)
        ),
      )
    ];

    List<Objective> publicObjectives = _presenter.getPublicObjectives();
    List<Widget> toInsert = [];

    for(int i = 0; i < 10; i++) {
      int value = (i < 5) ? 1 : 2;
      if(i < publicObjectives.length) {
        toInsert.add(
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ObjectiveView(
              value: publicObjectives[i].getValue(),
              child: OutlinedLetters(content: '${publicObjectives[i].numPlayersCompleted()}'),
            ),
          )
        );
      }
      else {
        toInsert.add(
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ObjectiveView(
              value: value,
            ),
          )
        );
      }      
    }

    int split = toInsert.length ~/ 2;
    
    toReturn.add(
      Column(
        children: [
          Row(
            children: toInsert.sublist(0, split),
          ),
          Row(
            children: toInsert.sublist(split, toInsert.length),
          )
        ]
      )
    );

    return toReturn;
  }
}

