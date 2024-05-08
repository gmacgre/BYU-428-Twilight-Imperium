import 'package:client/board/coordinate.dart';
import 'package:client/model/riverpod/board_state.dart';
import 'package:client/model/ship_model.dart';
import 'package:client/model/turn_phase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ship_selector_provider.g.dart';

@riverpod
class ShipSelector extends _$ShipSelector {
  @override
  ShipSelectorObject build() {
    return ShipSelectorObject();
  }

  void activate(Coordinate coordinate) {
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

  void selectShip(ShipModel ship) {
    var selectedShips = {...state.selectedShips};
    var selectedCoordinate = ref.read(boardStateProvider).selectedCoordinate;
    if (selectedCoordinate != null) {
      if (selectedShips[selectedCoordinate] == null) {
        selectedShips[selectedCoordinate] = [];
      }
      selectedShips[selectedCoordinate]!.add(ship);
    }

    state = ShipSelectorObject(
      selectedShips: selectedShips,
    );
  }

  void deselectShip(ShipModel ship) {
    var selectedShips = {...state.selectedShips};
    var selectedCoordinate = ref.read(boardStateProvider).selectedCoordinate;
    if (selectedCoordinate != null) {
      if (selectedShips[selectedCoordinate] != null) {
        selectedShips[selectedCoordinate]!.remove(ship);
      }
    }
    state = ShipSelectorObject(
      selectedShips: selectedShips,
    );
  }

  void submit() {
    ref.read(boardStateProvider.notifier).moveShips(
          map: state.selectedShips,
        );
    state = ShipSelectorObject();
  }

  void cancel() {
    state = ShipSelectorObject();
  }
}

class ShipSelectorObject {
  Map<Coordinate, List<ShipModel>> selectedShips;

  ShipSelectorObject({
    this.selectedShips = const {},
  });
}
