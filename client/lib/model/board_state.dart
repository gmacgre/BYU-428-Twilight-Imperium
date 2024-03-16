import 'package:client/board/coordinate.dart';
import 'package:client/data/datacache.dart';
import 'package:client/model/ship_model.dart';
import 'package:client/model/system_state.dart';
import 'package:client/service/messaging/activation_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_state.g.dart';

@riverpod
class BoardState extends _$BoardState {
  final ActivationService _activateService =
      ActivationService(_ActivateServiceObserver());

  @override
  BoardStateObject build() {
    // This will need to get the cached state from the DataCache
    // This can be used to undo any modifications to the state and revert to the last saved state.
    return BoardStateObject(systemStates: DataCache.instance.boardState, isModified: false);
  }

  void updateSystem(SystemState newState, Coordinate coordinate) {
    var systems = [...state.systemStates];
    systems[coordinate.q][coordinate.r] = newState;
    state = BoardStateObject(
        systemStates: systems, activeCoordinate: state.activeCoordinate);
    //Any call to the server can be made here to send the request
  }

  /// This is used to move ships from one system to another.
  /// The move for each ship should have already been validated.
  void moveShips({required Coordinate from, required List<ShipModel> ships}) {
    if (ships.isEmpty) {
      return;
    }
    var fromSystem = state.systemStates[from.q][from.r];

    List<ShipModel> shipsToAdd = List.empty(growable: true);
    for (int i = 0; i < ships.length; i++) {
      fromSystem.airSpace.remove(ships[i]);
      shipsToAdd.add(ships[i]);
    }
    var systems = [...state.systemStates];
    var toSystem = state.systemStates[state.activeCoordinate!.q]
        [state.activeCoordinate!.r];

    systems[from.q][from.r] = SystemState(
        systemModel: fromSystem.systemModel, airSpace: fromSystem.airSpace);
    systems[state.activeCoordinate!.q][state.activeCoordinate!.r] = SystemState(
      systemModel: toSystem.systemModel,
      airSpace: [
        ...shipsToAdd,
        ...toSystem.airSpace,
      ],
    );

    state = BoardStateObject(
        systemStates: systems, activeCoordinate: state.activeCoordinate);
  }

  void addShip(ShipModel ship, Coordinate coordinate) {
    var system = state.systemStates[coordinate.q][coordinate.r];
    system.airSpace.add(ship);
    updateSystem(system, coordinate);
  }

  void removeShip(ShipModel ship, Coordinate coordinate) {
    var system = state.systemStates[coordinate.q][coordinate.r];
    system.airSpace.remove(ship);
    updateSystem(system, coordinate);
  }

  void activateSystem(Coordinate coordinate) {
    _activateService.sendActivationRequest(coordinate.q, coordinate.r);
    state = BoardStateObject(
      systemStates: state.systemStates,
      activeCoordinate: coordinate,
    );
  }

  void deactivateSystem(Coordinate coordinate) {
    state = BoardStateObject(
      systemStates: state.systemStates,
      activeCoordinate: null,
    );
  }
}

///This is used to represent the state of the board.
///Since there is more to the state than just the system states, this allows for easy access to all state variables.
class BoardStateObject {
  final List<List<SystemState>> systemStates;
  final Coordinate? activeCoordinate;
  final bool isModified;
  BoardStateObject({
    required this.systemStates,
    this.activeCoordinate,
    this.isModified = true,
  });
}

class _ActivateServiceObserver implements ActivationServiceObserver {
  @override
  void notifySent() {
    // TODO: implement notifySent
    print('activation sent');
  }

  @override
  void notifySuccess() {
    // TODO: implement notifySuccess
    print('activation successful');
  }

  @override
  void notifyFailure(String message) {
    // TODO: implement notifyFailure
    print('activation failed');
  }
}
