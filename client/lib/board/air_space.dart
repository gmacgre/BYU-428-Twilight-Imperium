import 'package:client/board/ship_icon.dart';
import 'package:client/model/ship_model.dart';
import 'package:flutter/material.dart';

class AirSpace extends StatelessWidget {
  const AirSpace({super.key, required this.ships});
  final List<ShipModel> ships;
  @override
  Widget build(BuildContext context) {
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
    List<Widget> shipCounters = List.filled(
      6,
      const SizedBox(),
    );
    int index = 0;
    if (carrierCount > 0) {
      shipCounters[index] = ShipIcon(
        type: 'C',
        count: carrierCount,
      );
      index++;
    }
    if (cruiserCount > 0) {
      shipCounters[index] = ShipIcon(
        type: 'R',
        count: cruiserCount,
      );
      index++;
    }
    if (destroyerCount > 0) {
      shipCounters[index] = ShipIcon(
        type: 'D',
        count: destroyerCount,
      );
      index++;
    }
    if (dreadnoughtCount > 0) {
      shipCounters[index] = ShipIcon(
        type: 'N',
        count: dreadnoughtCount,
      );
      index++;
    }
    if (fighterCount > 0) {
      shipCounters[index] = ShipIcon(
        type: 'F',
        count: fighterCount,
      );
      index++;
    }
    if (flagshipCount > 0) {
      shipCounters[index] = ShipIcon(
        type: 'L',
        count: flagshipCount,
      );
      index++;
    }
    if (warsunCount > 0) {
      shipCounters[index] = ShipIcon(
        type: 'W',
        count: warsunCount,
      );
      index++;
    }

    return Center(
      child: SizedBox(
        width: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                shipCounters[0],
                shipCounters[1],
                shipCounters[2],
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                shipCounters[3],
                shipCounters[4],
                shipCounters[5],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
