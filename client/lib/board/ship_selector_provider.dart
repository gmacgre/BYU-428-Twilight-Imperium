import 'package:client/board/coordinate.dart';
import 'package:client/model/board_state.dart';
import 'package:client/model/ship_model.dart';
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
    if (coordinate == ref.read(boardStateProvider).activeCoordinate) {
      return;
    }
    if(ref.read(boardStateProvider).currentPhase != TurnPhase.movement) {
      return;
    }
    var selectedShips = {...state.selectedShips};
    state = ShipSelectorObject(
      selectedShips: selectedShips,
      selectedCoordinate: coordinate,
    );
  }

  void selectShip(ShipModel ship) {
    var selectedShips = {...state.selectedShips};
    var selectedCoordinate = state.selectedCoordinate;
    if (selectedCoordinate != null) {
      if (selectedShips[selectedCoordinate] == null) {
        selectedShips[selectedCoordinate] = [];
      }
      selectedShips[selectedCoordinate]!.add(ship);
    }

    state = ShipSelectorObject(
      selectedShips: selectedShips,
      selectedCoordinate: selectedCoordinate,
    );
  }

  void deselectShip(ShipModel ship) {
    var selectedShips = {...state.selectedShips};
    var selectedCoordinate = state.selectedCoordinate;
    if (selectedCoordinate != null) {
      if (selectedShips[selectedCoordinate] != null) {
        selectedShips[selectedCoordinate]!.remove(ship);
      }
    }

    state = ShipSelectorObject(
      selectedShips: selectedShips,
      selectedCoordinate: selectedCoordinate,
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
  Coordinate? selectedCoordinate;

  ShipSelectorObject({
    this.selectedShips = const {},
    this.selectedCoordinate,
  });
}
