import 'package:client/info/presenter/global_info_presenter.dart';
import 'package:client/info/player_overview.dart';
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

    //TODO: AGENDAS, UNTAKEN STRATEGY CARDS
    toReturn.add(const Padding(
        padding: EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 10.0),
        child: Placeholder()
      )
    );
    return toReturn;
  }
}

