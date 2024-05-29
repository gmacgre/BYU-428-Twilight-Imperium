import 'package:client/data/datacache.dart';
import 'package:client/res/coordinate.dart';
import 'package:client/model/riverpod/board_state.dart';
import 'package:client/model/turn_phase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ship_selector_provider.g.dart';

@riverpod
class ShipSelector extends _$ShipSelector {
  @override
  ShipSelectorObject build() {
    Map<Coords, List<bool>> oldState = DataCache.instance.selectedShips;
    DataCache.instance.selectedShips = {};
    return ShipSelectorObject(selectedShips: oldState);
  }

  void activate(Coords coordinate) {
    if (ref.read(boardStateProvider).activeCoordinate == null) {
      return;
    }
    if(ref.read(boardStateProvider).currentPhase != TurnPhase.movement) {
      return;
    }
    ref.read(boardStateProvider.notifier).selectSystem(coordinate);
    var selectedShips = {...state.selectedShips};
    state = ShipSelectorObject(
      selectedShips: selectedShips,
    );
  }

  void selectShip(int idx) {
    var selectedShips = {...state.selectedShips};
    var selectedCoordinate = ref.read(boardStateProvider).selectedCoordinate;
    if (selectedCoordinate == null) {
      return;
    }
    if (selectedShips[selectedCoordinate] == null) {
      // make an array of airspace size
      int size = ref.read(boardStateProvider).systemStates[selectedCoordinate.x][selectedCoordinate.y].airSpace.length;
      selectedShips[selectedCoordinate] = List.filled(size, false, growable: false);
    }
    selectedShips[selectedCoordinate]![idx] = true;

    state = ShipSelectorObject(
      selectedShips: selectedShips,
    );
  }

  void deselectShip(int idx) {
    var selectedShips = {...state.selectedShips};
    var selectedCoordinate = ref.read(boardStateProvider).selectedCoordinate;
    if (selectedCoordinate == null) {
      return;
    }
    // Remove from the Move Order
    selectedShips[selectedCoordinate]![idx] = false;

    // Check if no ships are ordered, and if so, remove the list from the map
    bool toRemove = true;
    for(bool b in selectedShips[selectedCoordinate]!) {
      if(b) {
        toRemove = false;
        break;
      }
    }
    if(toRemove) {
      selectedShips.remove(selectedCoordinate);
    }

    // Set the new State
    state = ShipSelectorObject(
      selectedShips: selectedShips,
    );
  }

  void submit() {
    ref.read(boardStateProvider.notifier).moveShips(
      orders: state.selectedShips,
    );
    cancel();
  }

  void cancel() {
    DataCache.instance.selectedShips = {};
    state = ShipSelectorObject();
  }

  void preSubmit() {
    DataCache.instance.selectedShips = state.selectedShips;
  }
}

class ShipSelectorObject {
  Map<Coords, List<bool>> selectedShips;

  ShipSelectorObject({
    this.selectedShips = const {},
  });
}
