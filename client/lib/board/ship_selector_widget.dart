import 'package:client/board/coordinate.dart';
import 'package:client/board/ship_selector_provider.dart';
import 'package:client/data/strings.dart';
import 'package:client/model/board_state.dart';
import 'package:client/res/outlined_letters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShipSelectorWidget extends ConsumerWidget {
  const ShipSelectorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool shipSelectorActive =
        ref.watch(boardStateProvider).currentPhase == TurnPhase.movement;
    Coordinate? selectedCoordinate =
        ref.watch(shipSelectorProvider).selectedCoordinate;
    var selectedShipsMap = ref.watch(shipSelectorProvider).selectedShips;
    var selectableShips = [];
    if (selectedCoordinate != null) {
      selectableShips = ref
          .watch(boardStateProvider)
          .systemStates[selectedCoordinate.q][selectedCoordinate.r]
          .airSpace;
    }
    var selectedShips = selectedShipsMap.values.expand((x) => x).toList();
    return Visibility(
      visible: shipSelectorActive,
      child: Material(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 300,
          color: Colors.blueGrey,
          child: Column(
            children: <Widget>[
              // Add selected ships here
              const OutlinedLetters(
                content: Strings.selectedShips,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: selectedShips.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        Strings.capitalize(
                            selectedShips[index].type.toString().split('.')[1]),
                      ),
                      // Add more properties of the ship model here
                    );
                  },
                ),
              ),
              const OutlinedLetters(
                content: Strings.selectableShips,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: selectableShips.length,
                  itemBuilder: (context, index) {
                    var ship = selectableShips[index];
                    bool isSelected = selectedShips.contains(ship);
                    return Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isSelected
                            ? Colors.amber.shade300
                            : Colors.transparent,
                      ),
                      child: ListTile(
                        textColor: Colors.grey.shade900,
                        iconColor: Colors.grey.shade900,
                        title: Text(
                            Strings.capitalize(
                                ship.type.toString().split('.')[1]),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        onTap: () {
                          if (isSelected) {
                            ref
                                .read(shipSelectorProvider.notifier)
                                .deselectShip(ship);
                          } else {
                            ref
                                .read(shipSelectorProvider.notifier)
                                .selectShip(ship);
                          }
                        },
                        trailing: IconButton(
                          icon: Icon(isSelected ? Icons.close : Icons.add),
                          onPressed: () {
                            if (isSelected) {
                              ref
                                  .read(shipSelectorProvider.notifier)
                                  .deselectShip(ship);
                            } else {
                              ref
                                  .read(shipSelectorProvider.notifier)
                                  .selectShip(ship);
                            }
                          },
                        ),
                        // Add more properties of the ship model here
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      ref.read(shipSelectorProvider.notifier).cancel();
                    },
                    child: const OutlinedLetters(content: Strings.cancel),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(shipSelectorProvider.notifier).submit();
                      // Handle submit button press
                    },
                    child: const OutlinedLetters(content: Strings.submit),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
