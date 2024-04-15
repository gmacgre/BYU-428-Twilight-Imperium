import 'package:client/board/board_space.dart';
import 'package:client/board/coordinate.dart';
import 'package:client/board/production_widget.dart';
import 'package:client/board/ship_selector_provider.dart';
import 'package:client/board/ship_selector_widget.dart';
import 'package:client/combat/combat_page.dart';
import 'package:client/data/strings.dart';
import 'package:client/model/board_state.dart';
import 'package:client/model/system_state.dart';
import 'package:client/res/outlined_letters.dart';
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
    List<List<SystemState>> systems =
        ref.watch(boardStateProvider).systemStates;
    Coordinate? activeCoordinate =
        ref.watch(boardStateProvider).activeCoordinate;
    Coordinate? selectedCoordinate =
        ref.watch(shipSelectorProvider).selectedCoordinate;
    TurnPhase phase = ref.watch(boardStateProvider).currentPhase;
    // If we are in combat, pull up the combat window
    if(phase == TurnPhase.combat) {
      return const CombatPage(state: CombatState.enteringCombat);
    }

    
    // Return the non-Combat Window
    String phaseString = phase.toString().split('.').last.toUpperCase();
    return Row(
      children: [
        Expanded(
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 12, 12, 40),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
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
                          coordinate: Coordinate(
                            coordinates.q + widget._depth,
                            coordinates.r + widget._depth,
                          ),
                          systemState: systems[(coordinates.q + widget._depth)]
                              [(coordinates.r + widget._depth)],
                          activated: (activeCoordinate?.q ==
                                  coordinates.q + widget._depth &&
                              activeCoordinate?.r ==
                                  coordinates.r + widget._depth),
                          selected: (selectedCoordinate?.q ==
                                  coordinates.q + widget._depth &&
                              selectedCoordinate?.r ==
                                  coordinates.r + widget._depth),
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 32,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.grey),
                        color: Colors.grey,
                      ),
                      child: Center(
                        child: DefaultTextStyle(
                          // This is needed because for some reason there is an underline on the text
                          // applied by the default style.
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          child: OutlinedLetters(
                            content: phaseString,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                        width: 140,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: phase == TurnPhase.production ||
                                  phase == TurnPhase.movement
                              ? MaterialStateProperty.all(Colors.amber.shade300)
                              : MaterialStateProperty.all(Colors.grey),
                        ),
                        onPressed: () {
                          ref.read(boardStateProvider.notifier).endPhase();
                        },
                        child: OutlinedLetters(
                            content: phase == TurnPhase.production
                                ? Strings.endTurn
                                : Strings.nextPhase),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const ShipSelectorWidget(),
        const ProductionWidget(),
      ],
    );
  }
}
