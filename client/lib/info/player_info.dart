import 'package:client/info/player_overview.dart';
import 'package:flutter/material.dart';
import 'package:client/info/presenter/player_info_presenter.dart';

class PlayerInfo extends StatefulWidget {
  
  final int playerIndex;

  const PlayerInfo({super.key, this.playerIndex = -1});

  @override
  State<PlayerInfo> createState() => _PlayerInfoState();
}

class _PlayerInfoState extends State<PlayerInfo> {

  late PlayerInfoPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = PlayerInfoPresenter(widget.playerIndex);
  }

  @override
  Widget build(BuildContext context) {
    return PlayerOverview(
      strategyCardId: _presenter.getStrategyCard(widget.playerIndex),
      tacticTokenCount: _presenter.getTacticPool(widget.playerIndex),
      fleetTokenCount: _presenter.getFleetPool(widget.playerIndex),
      strategyTokenCount: _presenter.getStrategyPool(widget.playerIndex),
      icon: _presenter.getIcon(widget.playerIndex),
      objScoredCount: _presenter.getObjScoredCount(widget.playerIndex), 
    );
  }
}