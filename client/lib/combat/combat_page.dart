import 'package:client/combat/combat_panel.dart';
import 'package:client/combat/combat_forces.dart';
import 'package:client/combat/force_makeup.dart';
import 'package:client/data/datacache.dart';
import 'package:client/data/strings.dart';
import 'package:flutter/material.dart';
import 'package:client/model/board_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CombatState {
  waiting,
  declareRetreat,
  assignHits,
  enteringCombat,
  exitingCombat
}

class CombatPage extends ConsumerStatefulWidget {
  const CombatPage({
    super.key,
    required this.state
  });

  final CombatState state;

  @override
  ConsumerState<CombatPage> createState() => _CombatPageState();
}

class _CombatPageState extends ConsumerState<CombatPage> {
  CombatState state = CombatState.enteringCombat;
  ForceMakeup allies = DataCache.instance.allies;
  ForceMakeup enemies = DataCache.instance.enemies;
  bool isRetreating = false;
  int hitsToAllocate = 0;
  Map<String, List<bool>> selections = {};
  late _CombatPanelHandler cph = _CombatPanelHandler(parent: this);
  late _CombatForcesHandler cfh = _CombatForcesHandler(parent: this);

  _CombatPageState() {
    resetSelections();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CombatForces(selectable: true, forces: allies, selections: selections, handler: cfh)
                ),
                Expanded(
                  flex: 1,
                  child: CombatForces(selectable: false, forces: enemies, selections: selections, handler: cfh)
                )
              ],
            )
          ),
          Expanded(
            flex: 1,
            child: CombatPanel(handler: cph, state: state),
          )
        ],
      ),
    );
  }

  void _swap(CombatState newState) {
    setState(() {
      state = newState;
    });
  }

  
  void _retreatOrder(bool retreating) {
    isRetreating = retreating;
    hitsToAllocate = enemies.fire();
    if(hitsToAllocate > allies.forceSize()) {
      hitsToAllocate = allies.forceSize();
    }
    resetSelections();
    _swap(CombatState.assignHits);
  }


  void _submitHits() {
    setState(() {
      int enemyHits = allies.fire();
      _hitEnemy(enemyHits);
      allies.flagship -= getMinus(Strings.flagship);
      allies.warsun -= getMinus(Strings.warsun);
      allies.dreadnaught -= getMinus(Strings.dreadnought);
      allies.cruiser -= getMinus(Strings.cruiser);
      allies.carrier -= getMinus(Strings.carrier);
      allies.destroyer -= getMinus(Strings.destroyer);
      allies.fighter -= getMinus(Strings.fighter);
      if(isRetreating) {
        state = CombatState.exitingCombat;
      }
      else if (allies.forceSize() == 0 || enemies.forceSize() == 0) {
        state = CombatState.exitingCombat;
      }
      else {
        state = CombatState.declareRetreat;
      }
      resetSelections();
    });
  }

  void _hitEnemy(int hits) {
    int assigned = 0;
    while(assigned < hits) {
      if(enemies.forceSize() == 0) break;
      if(enemies.fighter > 0) {
        enemies.fighter--;
        assigned++;
        continue;
      }
      if(enemies.destroyer > 0) {
        enemies.destroyer--;
        assigned++;
        continue;
      }
      if(enemies.cruiser > 0) {
        enemies.cruiser--;
        assigned++;
        continue;
      }
      if(enemies.carrier > 0) {
        enemies.carrier--;
        assigned++;
        continue;
      }
      if(enemies.dreadnaught > 0) {
        enemies.dreadnaught--;
        assigned++;
        continue;
      }
      if(enemies.warsun > 0) {
        enemies.warsun--;
        assigned++;
        continue;
      }
      if(enemies.flagship > 0) {
        enemies.flagship--;
        assigned++;
        continue;
      }
    
    }
  }

  int getMinus(String key) {
    var list = selections[key];
    if(list == null) {
      return 0;
    }
    else {
      return list.fold(0, (previousValue, element) => (element)? previousValue + 1: previousValue);
    }
  }

  void resetSelections() {
    selections = {
      Strings.flagship : [],
      Strings.warsun : [],
      Strings.dreadnought : [],
      Strings.cruiser : [],
      Strings.carrier : [],
      Strings.destroyer : [],
      Strings.fighter : [],
    };
    for(int i = 0; i < allies.flagship; i++) {
      selections[Strings.flagship]?.add(false);
    }
    for(int i = 0; i < allies.warsun; i++) {
      selections[Strings.warsun]?.add(false);
    }
    for(int i = 0; i < allies.dreadnaught; i++) {
      selections[Strings.dreadnought]?.add(false);
    }
    for(int i = 0; i < allies.cruiser; i++) {
      selections[Strings.cruiser]?.add(false);
    }
    for(int i = 0; i < allies.carrier; i++) {
      selections[Strings.carrier]?.add(false);
    }
    for(int i = 0; i < allies.destroyer; i++) {
      selections[Strings.destroyer]?.add(false);
    }
    for(int i = 0; i < allies.fighter; i++) {
      selections[Strings.fighter]?.add(false);
    }
  }

  void _selectItem(String key, int loc) {
    setState(() {
      var arr = selections[key];
      if(arr == null) return; 
      arr[loc] = !arr[loc];
      if(arr[loc]) {
        hitsToAllocate--;
      }
      else {
        hitsToAllocate++;
      }
    });
  }

  int _getHits() {
    return hitsToAllocate;
  }

  void _nextPhase() {
    ref.read(boardStateProvider.notifier).endPhase();
  }
}

class _CombatPanelHandler implements CombatPanelHandler {
  _CombatPanelHandler({
    required this.parent
  });
  final _CombatPageState parent;
  
  @override
  int getHits() {
    return parent._getHits();
  }
  
  @override
  void retreatOrder(bool retreating) {
    parent._retreatOrder(retreating);
  }
  
  @override
  void submitHits() {
    parent._submitHits();
  }
  
  @override
  void swap(CombatState newState) {
    parent._swap(newState);
  }

  @override
  void nextPhase() {
    parent._nextPhase();
  }
}

class _CombatForcesHandler implements CombatForcesHandler {
  final _CombatPageState parent;
  _CombatForcesHandler({
    required this.parent
  });

  @override
  void selectItem(String key, int loc) {
    parent._selectItem(key, loc);
  }
}