import 'package:client/model/player.dart';
import 'package:client/pages/game/info/player_overview.dart';
import 'package:flutter/material.dart';

class PlayerInfo extends StatelessWidget {

  final int index;
  final Player player;

  const PlayerInfo({
    super.key,
    required this.index,
    required this.player
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PlayerOverview(
          strategyCardId: player.getStrategyCard(),
          tacticTokenCount: player.getTacticPool(),
          fleetTokenCount: player.getFleetPool(),
          strategyTokenCount: player.getStrategyPool(),
          race: player.getName(),
          victoryPoints: player.getVictoryPoints(),
          playerColor: index, 
        ),
      ],
    );
  }
}