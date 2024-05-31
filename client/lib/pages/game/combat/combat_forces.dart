import 'package:client/pages/game/combat/force_makeup.dart';
import 'package:client/data/strings.dart';
import 'package:client/res/unit_tokens/carrier.dart';
import 'package:client/res/unit_tokens/cruiser.dart';
import 'package:client/res/unit_tokens/destroyer.dart';
import 'package:client/res/unit_tokens/dreadnaught.dart';
import 'package:client/res/unit_tokens/fighter.dart';
import 'package:client/res/unit_tokens/flagship.dart';
import 'package:client/res/unit_tokens/war_sun.dart';
import 'package:flutter/material.dart';

class CombatForces extends StatelessWidget {
  const CombatForces({
    super.key,
    required this.forces,
    required this.selectable,
    required this.selections,
    required this.handler 
  });
  final ForceMakeup forces;
  final bool selectable;
  final Map<String, List<bool>> selections;
  final CombatForcesHandler handler;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 12, 12, 40)),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: _getColumn(),
      ),
    );
  }

  List<Widget> _getColumn() {
    Color fill = (selectable) ? const Color.fromARGB(255, 8, 59, 101) : const Color.fromARGB(255, 94, 25, 20);
    List<Widget> toReturn = [];
    if(forces.flagship + forces.warsun > 0) {
      toReturn = [ ...toReturn, ..._buildFlagshipRow(fill) ];
    }
    if(forces.dreadnaught > 0) {
      toReturn = [ ...toReturn, ..._buildUnitRow(Strings.dreadnought, forces.dreadnaught, DreadnaughtIcon(outline: Colors.grey, fill: fill, combat: 6, move: 1, capacity: 1, cost: 4, width: 200, height: 100)) ];
    }
    if(forces.cruiser > 0) {
      toReturn = [ ...toReturn, ..._buildUnitRow(Strings.cruiser, forces.cruiser, CruiserIcon(outline: Colors.grey, fill: fill, combat: 7, move: 2, capacity: 0, cost: 2, width: 200, height: 100)) ];
    }
    if(forces.carrier > 0) {
      toReturn = [ ...toReturn, ..._buildUnitRow(Strings.carrier, forces.carrier, CarrierIcon(outline: Colors.grey, fill: fill, combat: 9, move: 1, capacity: 4, cost: 3, width: 200, height: 100)) ];
    }
    if(forces.destroyer > 0) {
      toReturn = [ ...toReturn, ..._buildUnitRow(Strings.destroyer, forces.destroyer, DestroyerIcon(outline: Colors.grey, fill: fill, combat: 8, move: 2, capacity: 0, cost: 1, width: 100, height: 50)) ];
    }
    if(forces.fighter > 0) {
      toReturn = [ ...toReturn, ..._buildUnitRow(Strings.fighter, forces.fighter, FighterIcon(outline: Colors.grey, fill: fill, combat: 9, move: 0, capacity: 0, cost: 1, width: 50, height: 50)) ];
    }
    return toReturn.map((e) => Center(child: e)).toList();
  }

  List<Widget> _buildFlagshipRow(Color fill) {
    List<bool> selected = selections[Strings.flagship]!;
    List<Widget> internals = [];
    Widget flagship = Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlagshipIcon(
        outline: Colors.grey, fill: fill, 
        combat: 7, move: 1, capacity: 2, cost: 8, 
        width: 200, height: 100
      ),
    );
    Widget warsun = Padding(
      padding: const EdgeInsets.all(8.0),
      child: WarSunIcon(
        outline: Colors.grey, fill: fill, 
        combat: 7, move: 1, capacity: 2, cost: 8, 
        width: 100, height: 100
      ),
    );
    for(int i = 0; i < forces.flagship; i++) {
      if(selectable) {
        internals.add(GestureDetector(
          onTap: () => handler.selectItem(Strings.flagship, i),
          child: selected[i] ? 
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.amber.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: flagship
            )
            : flagship,
        ));
      }
      else {
        internals.add(flagship);
      }
    }
    selected = selections[Strings.warsun]!;
    for(int i = 0; i < forces.warsun; i++) {
      if(selectable) {
        internals.add(GestureDetector(
          onTap: () => handler.selectItem(Strings.warsun, i),
          child: selected[i] ? 
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.amber.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: warsun
            )
            : warsun,
        ));
      }
      else {
        internals.add(warsun);
      }
    }

    return [ Wrap(children: internals.map((e) => Padding(padding: const EdgeInsets.all(5.0), child: e,)).toList()) ];
  }

  List<Widget> _buildUnitRow(String key, int count, Widget internal) {
    internal = Padding(
      padding: const EdgeInsets.all(8.0),
      child: internal,
    );
    List<bool> selected = selections[key]!;
    
    List<Widget> internals = [];
    for(int i = 0; i < count; i++) {
      if(selectable) {
        internals.add(GestureDetector(
          onTap: () => handler.selectItem(key, i),
          child: selected[i] ? 
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: internal
            )
            : internal,
        ));
      }
      else {
        internals.add(internal);
      }
    }
    return [ Wrap(children: internals.map((e) => Padding(padding: const EdgeInsets.all(5.0), child: e,)).toList()) ];
  }  
}

abstract interface class CombatForcesHandler {
  void selectItem(String key, int loc);
}