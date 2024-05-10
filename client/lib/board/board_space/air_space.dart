import 'package:client/board/board_space/board_click_interface.dart';
import 'package:client/data/strings.dart';
import 'package:client/model/player.dart';
import 'package:client/model/ship_model.dart';
import 'package:client/res/hover_tip.dart';
import 'package:flutter/material.dart';

class AirSpace extends StatelessWidget {
  const AirSpace({
    super.key, 
    required this.constraints,
    required this.ships,
    required this.owner,
    required this.player,
    required this.listener
  });
  final List<ShipModel> ships;
  final int owner;
  final Player? player;
  final BoxConstraints constraints;
  final BoardClickInterface listener;
  @override
  Widget build(BuildContext context) {
  
    if(player == null || owner == -1) {
      return Container();
    }
    //This just hopes you never have more than 6 types of ship in one system
    int carrierCount = 0;
    int cruiserCount = 0;
    int destroyerCount = 0;
    int dreadnoughtCount = 0;
    int fighterCount = 0;
    int flagshipCount = 0;
    int warsunCount = 0;
    for (var ship in ships) {
      switch (ship.type) {
        case ShipType.carrier:
          carrierCount++;
        case ShipType.cruiser:
          cruiserCount++;
        case ShipType.destroyer:
          destroyerCount++;
        case ShipType.dreadnought:
          dreadnoughtCount++;
        case ShipType.flagship:
          flagshipCount++;
        case ShipType.fighter:
          fighterCount++;
        case ShipType.warsun:
          warsunCount++;
      }
    }
    String hoverContent = '${player!.getName()} Airspace';
    if (warsunCount != 0) {
      hoverContent = '$hoverContent\n$warsunCount WarSun(s)';
    }
    if (flagshipCount != 0) {
      hoverContent = '$hoverContent\n$flagshipCount Flagship(s)';
    }
    if (dreadnoughtCount != 0) {
      hoverContent = '$hoverContent\n$dreadnoughtCount Dreadnought(s)';
    }
    if (cruiserCount != 0) {
      hoverContent = '$hoverContent\n$cruiserCount Cruiser(s)';
    }
    if (carrierCount != 0) {
      hoverContent = '$hoverContent\n$carrierCount Carrier(s)';
    }
    if (destroyerCount != 0) {
      hoverContent = '$hoverContent\n$destroyerCount Destroyer(s)';
    }
    if (fighterCount != 0) {
      hoverContent = '$hoverContent\n$fighterCount Fighter(s)';
    }
    String iconLoc = Strings.raceIcon(player!.getName());
    double size = constraints.maxWidth * 0.33;
    return GestureDetector(
      onTap: () {
        listener.processTap();
      },
      onDoubleTap: () {
        listener.processDoubleTap();
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(constraints.maxWidth * 0.03, constraints.maxHeight * 0.23, 0, 0),
        child: HoverTip(
          message: hoverContent,
          child: SizedBox(
            height: size, 
            width: size,
            child: Image.asset(iconLoc, fit: BoxFit.fitWidth,),
          )
        ),
      ),
    );    
  }
}
