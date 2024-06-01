import 'package:client/data/ship_data.dart';
import 'package:client/data/system_data.dart';
import 'package:client/model/player.dart';
import 'package:client/model/request_response/update/air_force_placed.dart';
import 'package:client/model/request_response/update/ground_force_placed.dart';
import 'package:client/model/request_response/update/pds_placed.dart';
import 'package:client/model/request_response/update/spacedock_placed.dart';
import 'package:client/model/request_response/update/system_placed.dart';
import 'package:client/model/riverpod/player_state.dart';
import 'package:client/model/riverpod/production_provider.dart';
import 'package:client/model/riverpod/ship_selector_provider.dart';
import 'package:client/res/coordinate.dart';
import 'package:client/data/datacache.dart';
import 'package:client/model/ship_model.dart';
import 'package:client/model/system_state.dart';
import 'package:client/model/turn_phase.dart';
import 'package:client/model/request_response/update/activate.dart';
import 'package:client/model/request_response/update/update.dart';
import 'package:client/service/game_logic/ship_movement.dart';
import 'package:client/service/messaging/activation_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_state.g.dart';

@riverpod
class BoardState extends _$BoardState {
  late final ActivationService _activateService; 

  late Coords? _activationHold;

  BoardState() {
    _activateService =
      ActivationService(_ActivateServiceObserver(owner: this));
  }

  @override
  BoardStateObject build() {
    // This will need to get the cached state from the DataCache
    // This can be used to undo any modifications to the state and revert to the last saved state.
    return BoardStateObject(
      systemStates: DataCache.instance.boardState, 
      isModified: false,
      activeCoordinate: (DataCache.instance.activeSystem.x + DataCache.instance.activeSystem.y > 0) ? DataCache.instance.activeSystem : null,
      activePlayer: DataCache.instance.activePlayer,
      currentPhase: DataCache.instance.phase,
      playerSeatNumber: DataCache.instance.userSeatNumber,
      oldState: null,
      alreadyProvided: const {'im', 'ac', 'ap', 'cp', 'ps'}
    );
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
    systems[state.activeCoordinate!.x][state.activeCoordinate!.y] =
        SystemState(systemModel: activeSystem.systemModel, airSpace: ships);
    state = BoardStateObject(
      systemStates: systems,
      oldState: state,
      alreadyProvided: const {}
    );
  }

  void updateSystem(SystemState newState, Coords coordinate) {
    var systems = [...state.systemStates];
    systems[coordinate.x][coordinate.y] = newState;
    state = BoardStateObject(
      systemStates: systems, 
      oldState: state,
      alreadyProvided: const {}
    );
    //Any call to the server can be made here to send the request
  }

  void setSystems(List<List<SystemState>> newSystems) {
    state = BoardStateObject(
      systemStates: newSystems,
      oldState: state,
      alreadyProvided: const {}
    );
  }

  /// This is used to move ships from one system to another.
  /// The move for each ship should have already been validated.
  void moveShips({required Map<Coords, List<bool>> orders}) {
    
    var systems = [...state.systemStates];
    var toSystem = systems[state.activeCoordinate!.x]
        [state.activeCoordinate!.y];

    for(var systemOrder in orders.entries) {
      var fromSystem = systems[systemOrder.key.x][systemOrder.key.y];
      var toMove = systemOrder.value;
      
      List<ShipModel> shipsToAdd = List.empty(growable: true);
      for (int i = 0; i < toMove.length; i++) {
        if(toMove[i] == true) {
          shipsToAdd.add(fromSystem.airSpace[i]);
        } 
      }

      for(int i = toMove.length - 1; i >= 0; i--) {
        if(toMove[i] == true) {
          fromSystem.airSpace.removeAt(i);
        }
      }

      fromSystem.systemOwner = (fromSystem.airSpace.isEmpty) ? -1 : systems[systemOrder.key.x][systemOrder.key.y].systemOwner;
      toSystem.airSpace =
      [
        ...shipsToAdd,
        ...toSystem.airSpace,
      ];
    }

    systems[state.activeCoordinate!.x][state.activeCoordinate!.y] = toSystem;
    
    if(state.activeSystemState!.systemOwner != -1 && state.activeSystemState!.systemOwner != state.activePlayer) {
      // Combat will ensue, find the collection of each sides forces
      _launchCombat();
    }
    else {
      systems[state.activeCoordinate!.x][state.activeCoordinate!.y].systemOwner = state.activePlayer;
      state.activeSystemState!.systemOwner = state.activePlayer;
      state = BoardStateObject(
        systemStates: systems,
        oldState: state,
        currentPhase: TurnPhase.production,
        highlightSet: {},
        distanceData: {},
        alreadyProvided: const {'cp', 'hs', 'dd'}
      );
    }
  }

  void endPhase() {
    var currentPhase = state.currentPhase;
    if (currentPhase == TurnPhase.activation && state.selectedCoordinate != null) {
      activateSystem(state.selectedCoordinate!);
      return;
    }
    if (currentPhase == TurnPhase.movement) {
      state = BoardStateObject(
        systemStates: state.systemStates,
        currentPhase: TurnPhase.combat,
        oldState: state,
        alreadyProvided: const {'cp'}
      );
      ref.read(shipSelectorProvider.notifier).cancel();
      return;
    }
    if (currentPhase == TurnPhase.combat) {
      state = BoardStateObject(
        systemStates: state.systemStates,
        currentPhase: TurnPhase.production,
        oldState: state,
        alreadyProvided: const {'cp'}
      );
    }
    if (currentPhase == TurnPhase.production) {
      endTurn();
      return;
    }
  }

  void selectSystem(Coords coordinate) {
    Coords? toSubmit = coordinate;
    if(state.selectedCoordinate != null && 
      (coordinate.x == state.selectedCoordinate!.x && coordinate.y == state.selectedCoordinate!.y)){
        toSubmit = null;
    }
    state = BoardStateObject(
      systemStates: state.systemStates,
      selectedCoordinate: toSubmit,
      oldState: state,
      alreadyProvided: const {'sc'}
    );
  }

  void activateSystem(Coords coordinate) {
    _activationHold = coordinate;
    _setSystemActive();
    _activateService.sendActivationRequest(coordinate.x, coordinate.y);
  }

  void _setSystemActive() {
    TurnPhase toSet = (state.activePlayer == state.playerSeatNumber) ? TurnPhase.movement : TurnPhase.observation;
    Set<Coords> validSources = {};
    Map<Coords, List<bool>> distanceData = {};
    if(toSet == TurnPhase.movement) {
      distanceData = ShipMovementLogic.possibleMoves(_activationHold!, state.systemStates, state.activePlayer);
    }
    validSources = distanceData.keys.toSet();
    state = BoardStateObject(
      systemStates: state.systemStates,
      activeCoordinate: _activationHold,
      currentPhase: toSet,
      oldState: state,
      highlightSet: validSources,
      distanceData: distanceData,
      alreadyProvided: const {'cp', 'ac', 'hs', 'dd'}
    );
    _activationHold = null;
  }

  void deactivateSystem(Coords coordinate) {
    state = BoardStateObject(
      systemStates: state.systemStates,
      activeCoordinate: null,
      oldState: state,
      alreadyProvided: const {'ac'}
    );
  }

  void endTurn() {
    //This will need to send the end turn request to the server
    DataCache.instance.boardState = state.systemStates;
    // Find the player with the next highest strategy card and make them the active player.
    List<Player> players = ref.read(playerStateProvider).players;
    int aPlayerCard = players[state.activePlayer].getStrategyCard();
    int nextPlayer = -1;
    int value = 0;
    for(int i = 0; i < players.length; i++) {
      if(i == state.activePlayer) {
        continue;
      }
      Player p = players[i];
      if(p.getPassed()) {
        continue;
      }
      // Getting this value requires some explanation- basically it naturally sorts the next card in sequence at value 7.
      // Subsequent cards get values 6, 5, 4 etc. until 1.
      int val = (aPlayerCard - p.getStrategyCard()) % 8;
      if(val > value) {
        value = val;
        nextPlayer = i;
      }
    }
    if(nextPlayer == -1) {
      //TODO: Only possible if all players have passed- go to Status phase
    }
    DataCache.instance.activePlayer = nextPlayer;
    DataCache.instance.phase = (DataCache.instance.userSeatNumber == nextPlayer) ? TurnPhase.activation : TurnPhase.observation;
    ref.invalidate(shipSelectorProvider);
    ref.invalidate(productionProvider);
    ref.invalidateSelf();
  }

  void processUpdates(List<Update> updates) {
    for(Update u in updates) {
      switch(u.type) {
        case 'activate': {
          if(u.info is ActivateUpdateInfo) {
            var info = u.info as ActivateUpdateInfo;
            _activationHold = Coords(info.coords.x, info.coords.y);
            _setSystemActive();
          }
          break;
        }
        case 'groundForcePlaced' : {
          if(u.info is GroundForcePlacedUpdateInfo) {
            var info = u.info as GroundForcePlacedUpdateInfo;
            if(state.systemStates[info.coords.x][info.coords.y].planets![info.planetIdx].numGroundForces == 0) {
              state.systemStates[info.coords.x][info.coords.y].planets![info.planetIdx].planetOwner = u.player; 
            }
            state.systemStates[info.coords.x][info.coords.y].planets![info.planetIdx].numGroundForces += info.quantity;
            state = BoardStateObject(systemStates: state.systemStates, oldState: state, alreadyProvided: {});
          }
          break;
        }
        case 'systemPlaced': {
          if(u.info is SystemPlacedUpdateInfo) {
            var info = u.info as SystemPlacedUpdateInfo;
            state.systemStates[info.coords.x][info.coords.y] = SystemState(systemModel: SystemData.systemList[info.system]!);
            state = BoardStateObject(systemStates: state.systemStates, oldState: state, alreadyProvided: {});
          }
          break;
        }
        case 'spacedockPlaced': {
          if(u.info is SpacedockPlacedUpdateInfo) {
            var info = u.info as SpacedockPlacedUpdateInfo;
            state.systemStates[info.coords.x][info.coords.y].planets![info.planetIdx].existsSpaceDock = true;
            state = BoardStateObject(systemStates: state.systemStates, oldState: state, alreadyProvided: {});
          }
          break;
        }
        case 'pdsPlaced': {
          if(u.info is PDSPlacedUpdateInfo) {
            var info = u.info as PDSPlacedUpdateInfo;
            state.systemStates[info.coords.x][info.coords.y].planets![info.planetIdx].numPDS++;
            state = BoardStateObject(systemStates: state.systemStates, oldState: state, alreadyProvided: {});
          }
          break;
        }
        case 'airforcePlaced': {
          if(u.info is AirForcePlacedUpdateInfo) {
            var info = u.info as AirForcePlacedUpdateInfo;
            if(state.systemStates[info.coords.x][info.coords.y].airSpace.isEmpty) {
              state.systemStates[info.coords.x][info.coords.y].systemOwner = u.player; 
            }
            for(ShipType type in info.airforce) {
              state.systemStates[info.coords.x][info.coords.y].airSpace.add(ShipData.defaultData[type]!);
            }
            state = BoardStateObject(systemStates: state.systemStates, oldState: state, alreadyProvided: {});
          }
          break;
        }
      }
      // TODO: ADD NEW UPDATE TYPES HERE
    }
  }

  void setPlayer(int activePlayer, int userSeatNumber) {
    state = BoardStateObject(
      systemStates: state.systemStates, 
      activePlayer: activePlayer,
      playerSeatNumber: userSeatNumber,
      oldState: state,
      alreadyProvided: const {'ap', 'ps'}
    );
  }

  void setPhase(TurnPhase phase) {
    state = BoardStateObject(
      systemStates: state.systemStates, 
      currentPhase: phase,
      oldState: state,
      alreadyProvided: const {'cp'}
    );
  }

  void setActiveSystem(Coords activeSystem) {
    state = BoardStateObject(
      systemStates: state.systemStates,
      activeCoordinate: activeSystem,
      oldState: state,
      alreadyProvided: const {'ac'}
    );
  }

  void invalidate() {
    ref.invalidate(shipSelectorProvider);
    ref.invalidate(productionProvider);
    ref.invalidateSelf();
  }

  void _launchCombat() {
    if (state.activeSystemState!.systemOwner != -1 &&
        DataCache.instance.userSeatNumber != state.activeSystemState!.systemOwner) {
      state = BoardStateObject(
        systemStates: state.systemStates,
        currentPhase: TurnPhase.activation,
        oldState: state,
        highlightSet: {},
        alreadyProvided: const {'cp', 'hs'}
      );
    } else {
      //I'm skipping ground invasions for now, if there is no space combat we're going straight to production
      state = BoardStateObject(
        //TODO : THIS WILL NEED TO BE MODIFIED LATER AS WELL
        systemStates: state.systemStates,
        currentPhase: TurnPhase.activation,
        oldState: state,
        alreadyProvided: const {'cp', 'hs'}
      );
    }
  }
}

///This is used to represent the state of the board.
///Since there is more to the state than just the system states, this allows for easy access to all state variables.
class BoardStateObject {
  late final List<List<SystemState>> systemStates; // A map of all the states
  late Coords? activeCoordinate;               // The most recent system to be activated in that turn
  late Coords? selectedCoordinate;       // Used for info panel, showing which system to display
  late bool isModified;                      // Unused, will be done when player is not up to date or is ahead of the server.
  late int playerSeatNumber;                 // Unused, denotes the clients seat number
  late TurnPhase currentPhase;                     // The current phase in a player's turn- TurnPhase.observe otherwise
  late SystemState? activeSystemState;        // The state of the currently active system, for easier access
  late int activePlayer;
  late Set<Coords> highlightSet;
  late Map<Coords, List<bool>> distanceData;

  static const List<String> _variableSet = [
    'ac', // activeCoordinate
    'sc', // selectedCoordinate
    'im', // isModified
    'ps', // playerSeatNumber
    'cp', // currentPhase
    'ap', // activePlayer
    'hs', // highlightSet
    'dd'  // distanceData
  ];



  // The proper way to construct this object is to first set the variables you want modified
  // into the constructor, with those being added to a set passsed at the end (alreadyProvided)
  // using the codes above in _variableSet. Adding in the old state will cause the new state to 
  // Union the changes with the old state, to keep continuity.
  BoardStateObject({
    required this.systemStates,
    this.activeCoordinate,
    this.selectedCoordinate,
    this.isModified = true,
    this.playerSeatNumber = -1,
    this.currentPhase = TurnPhase.activation,
    this.activePlayer = 0,
    this.highlightSet = const {},
    this.distanceData = const {},
    required BoardStateObject? oldState,
    required Set<String> alreadyProvided
  }) {
    if (oldState == null) {
      return;
    }
    for (String code in _variableSet) {
      if (alreadyProvided.contains(code)) {
        continue;
      }
      switch(code) {
        case 'ac': {
          activeCoordinate = oldState.activeCoordinate;
          break;
        }
        case 'sc': {
          selectedCoordinate = oldState.selectedCoordinate;
        }
        case 'im': {
          isModified = oldState.isModified;
        }
        case 'ps': {
          playerSeatNumber = oldState.playerSeatNumber;
        }
        case 'cp': {
          currentPhase = oldState.currentPhase;
        }
        case 'ap': {
          activePlayer = oldState.activePlayer;
        }
        case 'hs': {
          highlightSet = oldState.highlightSet;
        }
        case 'dd': {
          distanceData = oldState.distanceData;
        }
      }
    }
    if (activeCoordinate != null) {
      activeSystemState =
          systemStates[activeCoordinate!.x][activeCoordinate!.y];
    }
    else {
      activeSystemState = null;
    }
  }
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
  void notifyFailure(String message) {}
}
