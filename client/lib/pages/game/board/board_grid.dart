import 'package:client/model/riverpod/player_state.dart';
import 'package:client/pages/game/board/board_space/board_space.dart';
import 'package:client/res/coordinate.dart';
import 'package:client/pages/game/combat/combat_page.dart';
import 'package:client/model/riverpod/board_state.dart';
import 'package:client/model/system_state.dart';
import 'package:client/model/turn_phase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexagon/hexagon.dart';

class BoardGrid extends ConsumerStatefulWidget {
  const BoardGrid({super.key});

  final int _depth = 3;

  @override
  ConsumerState<BoardGrid> createState() => _BoardGridState();
}

class _BoardGridState extends ConsumerState<BoardGrid> {
  @override
  Widget build(BuildContext context) {
    // This is for making sure the board updates even if only players are involved.
    // Do not remove.
    ref.watch(playerStateProvider).players;
    
    List<List<SystemState>> systems =
        ref.watch(boardStateProvider).systemStates;
    Coords? activeCoordinate =
        ref.watch(boardStateProvider).activeCoordinate;
    Coords? selectedCoordinate =
        ref.watch(boardStateProvider).selectedCoordinate;
    TurnPhase phase = ref.watch(boardStateProvider).currentPhase;
    Set<Coords> highlightable = ref.watch(boardStateProvider).highlightSet;
    // If we are in combat, pull up the combat window
    if(phase == TurnPhase.combat) {
      return const CombatPage(state: CombatState.enteringCombat);
    }

    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: InteractiveViewer(
        child: HexagonGrid.flat(
          depth: widget._depth,
          padding: EdgeInsets.zero,
          buildTile: (coordinates) => HexagonWidgetBuilder(
            padding: 2.0,
            cornerRadius: 0,
            color: const Color.fromARGB(255, 0, 0, 100),
          ),
          buildChild: (coordinates) {
            //Adding the _depth is necessary to force everything to be a positive value.
            //The hex grid makes the origin (0,0) the middle of the grid, but since
            //lists can't have negative indexes we need to adjust accordingly.
            //To translate from model to view, subtract _depth to coordinates
            //To transalte from view to model, add _depth from coordinates
            return BoardSpace(
              coordinate: Coords(
                coordinates.q + widget._depth,
                coordinates.r + widget._depth,
              ),
              systemState: systems[(coordinates.q + widget._depth)]
                  [(coordinates.r + widget._depth)],
              activated: (activeCoordinate?.x ==
                      coordinates.q + widget._depth &&
                  activeCoordinate?.y ==
                      coordinates.r + widget._depth),
              selected: (selectedCoordinate?.x ==
                      coordinates.q + widget._depth &&
                  selectedCoordinate?.y ==
                      coordinates.r + widget._depth),
              highlight: highlightable.contains(Coords(coordinates.q + widget._depth,
                coordinates.r + widget._depth))
            );
          },
        ),
      ),
    );
  }
}
