import 'package:client/board/coordinate.dart';
import 'package:client/board/production_provider.dart';
import 'package:client/board/ship_selector_provider.dart';
import 'package:client/data/datacache.dart';
import 'package:client/model/player.dart';
import 'package:client/model/ship_model.dart';
import 'package:client/model/system_state.dart';
import 'package:client/service/messaging/activation_service.dart';
import 'package:flutter/material.dart';
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
          systemStates: state.systemStates,
          activeCoordinate: state.activeCoordinate,
          currentPhase: TurnPhase.production);
    }
  }

  void endPhase() {
    var currentPhase = state.currentPhase;
    if (currentPhase == TurnPhase.movement) {
      state = BoardStateObject(
        systemStates: state.systemStates,
        activeCoordinate: state.activeCoordinate,
        currentPhase: TurnPhase.production,
      );
      ref.read(shipSelectorProvider.notifier).cancel();
      return;
    }
    if (currentPhase == TurnPhase.production) {
      endTurn();
      return;
    }
  }

  void activateSystem(Coordinate coordinate) {
    _activateService.sendActivationRequest(coordinate.q, coordinate.r);
    state = BoardStateObject(
      systemStates: state.systemStates,
      activeCoordinate: coordinate,
      currentPhase: TurnPhase.movement,
    );
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
}

///This is used to represent the state of the board.
///Since there is more to the state than just the system states, this allows for easy access to all state variables.
class BoardStateObject {
  final List<List<SystemState>> systemStates;
  final Coordinate? activeCoordinate;
  final bool isModified;
  final int currentPlayerSeatNumber;
  final TurnPhase currentPhase;
  late SystemState? activeSystemState;
  BoardStateObject({
    required this.systemStates,
    this.activeCoordinate,
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

class _ActivateServiceObserver implements ActivationServiceObserver {
  @override
  void notifySent() {
    // TODO: implement notifySent
  }

  @override
  void notifySuccess() {
    // TODO: implement notifySuccess
  }

  @override
  void notifyFailure(String message) {
    // TODO: implement notifyFailure
  }
}
