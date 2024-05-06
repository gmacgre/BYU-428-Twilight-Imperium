import 'package:client/board/coordinate.dart';
import 'package:client/board/production_provider.dart';
import 'package:client/board/ship_selector_provider.dart';
import 'package:client/data/datacache.dart';
import 'package:client/model/ship_model.dart';
import 'package:client/model/system_state.dart';
import 'package:client/model/update/activate.dart';
import 'package:client/model/update/update.dart';
import 'package:client/service/messaging/activation_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_state.g.dart';

@riverpod
class BoardState extends _$BoardState {
  late final ActivationService _activateService; 

  late Coordinate? _activationHold;

  BoardState() {
    _activateService =
      ActivationService(_ActivateServiceObserver(owner: this));
  }

  @override
  BoardStateObject build() {
    // This will need to get the cached state from the DataCache
    // This can be used to undo any modifications to the state and revert to the last saved state.
    return BoardStateObject(
        systemStates: DataCache.instance.boardState, isModified: false);
  }

  void addShips(Map<ShipType, int> shipQuantities) {
    var systems = [...state.systemStates];
    var activeSystem = state.activeSystemState;
    if (activeSystem == null) {
      return;
    }
    var ships = activeSystem.airSpace;
    for (var entry in shipQuantities.entries) {
      var type = entry.key;
      var quantity = entry.value;
      for (int i = 0; i < quantity; i++) {
        ships.add(
          // TODO: This should be replaced with the actual ship stats
          ShipModel(
            0,
            0,
            0,
            0,
            type,
          ),
        );
      }
    }
    systems[state.activeCoordinate!.q][state.activeCoordinate!.r] =
        SystemState(systemModel: activeSystem.systemModel, airSpace: ships);
    state = BoardStateObject(
      systemStates: systems,
      activeCoordinate: state.activeCoordinate,
      isModified: true,
      currentPhase: state.currentPhase,
    );
  }

  void updateSystem(SystemState newState, Coordinate coordinate) {
    var systems = [...state.systemStates];
    systems[coordinate.q][coordinate.r] = newState;
    state = BoardStateObject(
        systemStates: systems, activeCoordinate: state.activeCoordinate);
    //Any call to the server can be made here to send the request
  }

  void setSystems(List<List<SystemState>> newSystems) {
    state = BoardStateObject(systemStates: newSystems);
  }

  /// This is used to move ships from one system to another.
  /// The move for each ship should have already been validated.
  void moveShips({required Map<Coordinate, List<ShipModel>> map}) {
    for (var entry in map.entries) {
      var from = entry.key;
      var ships = entry.value;
      debugPrint('Moving ships from $from to ${state.activeCoordinate}');
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
      systems[state.activeCoordinate!.q][state.activeCoordinate!.r] =
          SystemState(
        systemModel: toSystem.systemModel,
        airSpace: [
          ...shipsToAdd,
          ...toSystem.airSpace,
        ],
      );
      state = BoardStateObject(
          systemStates: systems, activeCoordinate: state.activeCoordinate);
    }
    //If someone owns the airspace and it's not the current player, go to combat phase
    // TODO: Real launch is here for later
    if (state.activeSystemState!.systemOwner != null &&
        DataCache.instance.userSeatNumber !=
            DataCache.instance.players
                .indexOf(state.activeSystemState!.systemOwner!)) {
      state = BoardStateObject(
          systemStates: state.systemStates,
          activeCoordinate: state.activeCoordinate,
          currentPhase: TurnPhase.combat);
    } else {
      //I'm skipping ground invasions for now, if there is no space combat we're going straight to production
      state = BoardStateObject(
        //TODO : THIS WILL NEED TO BE MODIFIED LATER AS WELL
          systemStates: state.systemStates,
          activeCoordinate: state.activeCoordinate,
          currentPhase: TurnPhase.combat);
    }
  }

  void endPhase() {
    var currentPhase = state.currentPhase;
    if (currentPhase == TurnPhase.activation && state.selectedCoordinate != null) {
      state = BoardStateObject(
        systemStates: state.systemStates,
        activeCoordinate: state.selectedCoordinate,
        currentPhase: TurnPhase.movement
      );
      return;
    }
    if (currentPhase == TurnPhase.movement) {
      state = BoardStateObject(
        systemStates: state.systemStates,
        activeCoordinate: state.activeCoordinate,
        currentPhase: TurnPhase.combat,
      );
      ref.read(shipSelectorProvider.notifier).cancel();
      return;
    }
    if (currentPhase == TurnPhase.combat) {
      state = BoardStateObject(
        systemStates: state.systemStates,
        activeCoordinate: state.activeCoordinate,
        currentPhase: TurnPhase.production
      );
    }
    if (currentPhase == TurnPhase.production) {
      endTurn();
      return;
    }
  }

  void selectSystem(Coordinate coordinate) {
    state = BoardStateObject(
      systemStates: state.systemStates,
      activeCoordinate: state.activeCoordinate,
      selectedCoordinate: coordinate,
      currentPhase: state.currentPhase
    );
  }

  void activateSystem(Coordinate coordinate) {
    print('activating a system');
    _activationHold = coordinate;
    _activateService.sendActivationRequest(coordinate.q, coordinate.r);
    state = BoardStateObject(
      systemStates: state.systemStates,
      activeCoordinate: coordinate,
      currentPhase: TurnPhase.movement,
    );
  }

  void _setSystemActive() {
    state = BoardStateObject(
      systemStates: state.systemStates,
      activeCoordinate: _activationHold,
      currentPhase: TurnPhase.movement,
    );
    _activationHold = null;
  }

  void deactivateSystem(Coordinate coordinate) {
    state = BoardStateObject(
      systemStates: state.systemStates,
      activeCoordinate: null,
    );
  }

  void endTurn() {
    //This will need to send the end turn request to the server
    DataCache.instance.boardState = state.systemStates;
    ref.invalidate(shipSelectorProvider);
    ref.invalidate(productionProvider);
    ref.invalidateSelf();
  }

  void processUpdates(List<Update> updates) {
    for(Update u in updates) {
      switch(u.type) {
        case 'activate': {
          if(u.info is ActivateUpdateInfo) {
            print('updating Activated location');
            var info = u.info as ActivateUpdateInfo;
            activateSystem(Coordinate(info.x, info.y));
          }
        }
        break;
      }
      // TODO: ADD NEW UPDATE TYPES HERE
    }
  }
}

///This is used to represent the state of the board.
///Since there is more to the state than just the system states, this allows for easy access to all state variables.
class BoardStateObject {
  final List<List<SystemState>> systemStates; // A map of all the states
  Coordinate? activeCoordinate;               // The most recent system to be activated in that turn
  final Coordinate? selectedCoordinate;       // Used for info panel, showing which system to display
  final bool isModified;                      // Unused, will be done when player is not up to date or is ahead of the server.
  final int currentPlayerSeatNumber;          // Unused, denotes the clients seat number
  TurnPhase currentPhase;                     // The current phase in a player's turn- TurnPhase.observe otherwise
  late SystemState? activeSystemState;        // The state of the currently active system, for easier access
  BoardStateObject({
    required this.systemStates,
    this.activeCoordinate,
    this.selectedCoordinate,
    this.isModified = true,
    this.currentPlayerSeatNumber = -1,
    this.currentPhase = TurnPhase.activation,
  }) {
    if (activeCoordinate != null) {
      activeSystemState =
          systemStates[activeCoordinate!.q][activeCoordinate!.r];
    }
  }
}

enum TurnPhase {
  activation,
  movement,
  combat,
  invasion,
  production,
}


// This should probably move to a subclass if I'm honest- not good to put business logic in our model.
class _ActivateServiceObserver implements ActivationServiceObserver {
  BoardState owner;
  _ActivateServiceObserver({
    required this.owner
  });
  @override
  void notifySent() {}

  @override
  void notifySuccess() {
    owner._setSystemActive();
  }

  @override
  void notifyFailure(String message) {
    print('failure');
  }
}
