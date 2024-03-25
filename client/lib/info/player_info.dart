import 'package:client/info/player_overview.dart';
import 'package:client/model/player.dart';
import 'package:client/res/unit_tokens/carrier.dart';
import 'package:client/res/unit_tokens/cruiser.dart';
import 'package:client/res/unit_tokens/destroyer.dart';
import 'package:client/res/unit_tokens/dreadnaught.dart';
import 'package:client/res/unit_tokens/fighter.dart';
import 'package:client/res/unit_tokens/flagship.dart';
import 'package:client/res/unit_tokens/war_sun.dart';
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
        const Center(
          child: DestroyerIcon(
            fill: Colors.purple,
            outline: Colors.black,
            cost: -1,
            move: -1,
            combat: -1,
            capacity: -1,
            width: 300,
            height: 250,
          ),
        ),
        const Center(
          child: FighterIcon(
            outline: Colors.black,
            fill: Colors.orange,
            combat: 9,
            move: 1,
            capacity: 4,
            cost: 3,
            width: 250,
            height: 250
          ),
        ),
        const Center(
          child: FlagshipIcon(
            fill: Colors.purple,
            outline: Colors.black,
            cost: -1,
            move: -1,
            combat: -1,
            capacity: -1,
            width: 500,
            height: 250,
          ),
        ),
        const Center(
          child: DreadnaughtIcon(
            outline: Colors.black,
            fill: Colors.blue, 
            combat: 4,
            move: 2, 
            capacity: 1, 
            cost: 4, 
            width: 500, 
            height: 250
          ),
        ),
        const Center(
          child: CruiserIcon(
            outline: Colors.black,
            fill: Colors.blue, 
            combat: 4,
            move: 2, 
            capacity: 1, 
            cost: 4, 
            width: 500, 
            height: 250
          ),
        ),
        const Center(
          child: CarrierIcon(
            outline: Colors.black,
            fill: Colors.orange,
            combat: 9,
            move: 1,
            capacity: 4,
            cost: 3,
            width: 500,
            height: 250
          ),
        ),
        const Center(
          child: WarSunIcon(
            outline: Colors.black,
            fill: Colors.orange,
            combat: 9,
            move: 1,
            capacity: 4,
            cost: 3,
            width: 250,
            height: 250
          ),
        )
      ],
    );
  }
}