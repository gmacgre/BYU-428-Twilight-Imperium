import 'package:client/info/presenter/global_info_presenter.dart';
import 'package:client/info/player_overview.dart';
import 'package:client/info/strategy_card.dart';
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
    return ListView(
      children: _buildChildren(),
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
            objScoredCount: _presenter.getObjScoredCount(i),
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
        padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
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
        padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Colors.blueAccent),
          child: Row(
            children: _getPublicObjectives(),
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
        child: OutlinedLetters(
          content: Strings.untakenStrategyCards
        ),
      ),
    ];
    List<int> untaken = _presenter.getUntakenStrategyCards();
    for(int i = 0; i < untaken.length; i++) {
      toReturn.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: StrategyCard(
            cardHeight: 50.0,
            cardWidth: 30.0,
            strategyCardId: untaken[i],
          ),
        )
      );
    }
    return toReturn;
  }

  List<Widget> _getPublicObjectives() {
    List<Widget> toReturn = [
      const OutlinedLetters(content: Strings.publicObjectives)
    ];
    
    return toReturn;
  }
}

