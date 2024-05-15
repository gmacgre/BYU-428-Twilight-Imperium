
import 'package:client/board/board_space/air_space.dart';
import 'package:client/board/board_space/board_click_interface.dart';
import 'package:client/board/board_space/system.dart';
import 'package:client/res/coordinate.dart';
import 'package:client/board/ship_selector_provider.dart';
import 'package:client/model/player.dart';
import 'package:client/model/riverpod/board_state.dart';
import 'package:client/model/riverpod/player_state.dart';
import 'package:client/model/system_state.dart';
import 'package:client/model/turn_phase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardSpace extends ConsumerStatefulWidget {
  const BoardSpace({
    super.key,
    required this.systemState,
    required this.coordinate,
    required this.activated,
    required this.selected,
  });
  final SystemState systemState;
  final Coords coordinate;
  final bool activated;
  final bool selected;

  @override
  ConsumerState<BoardSpace> createState() => _BoardSpaceState();
}

class _BoardSpaceState extends ConsumerState<BoardSpace> {
  late _BoardClick _listener;
  late TurnPhase phase;
  late int activePlayer;
  late int seatId;
  late bool existsActivatedSystem;
  @override
  Widget build(BuildContext context) {
    _listener = _BoardClick(this);
    Color overlay = const Color.fromARGB(0, 0, 0, 0);
    existsActivatedSystem =
        ref.watch(boardStateProvider).activeCoordinate != null;
    phase = ref.read(boardStateProvider).currentPhase;
    activePlayer = ref.read(boardStateProvider).activePlayer;
    seatId = ref.read(boardStateProvider).playerSeatNumber;
    int airSpaceOwner = widget.systemState.systemOwner;
    Player? playerASOwner = (airSpaceOwner != -1) ? ref.read(playerStateProvider).players[airSpaceOwner] : null;
    if (widget.activated) {
      overlay = const Color.fromARGB(155, 255, 100, 55);
    }
    if (widget.selected) {
      overlay = const Color.fromARGB(155, 0, 187, 212);
    }
    if (widget.selected && widget.activated) {
      overlay = const Color.fromARGB(155, 128, 144, 134);
    }
    return LayoutBuilder(
      builder: (context, constraints) { return Stack(
        children: [
          GestureDetector(
            onTap: () => _processTap(),
            onDoubleTap: () => _processDoubleTap(),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: overlay,
              ),
            ),
          ),
          System(
            constraints, 
            widget.systemState.systemModel, 
            widget.systemState.planets,
            _listener
          ),
          AirSpace(
            constraints: constraints,
            ships: widget.systemState.airSpace,
            owner: airSpaceOwner,
            player: playerASOwner,
            listener: _listener
          ),
        ],
      );
      }
    );
  }

  _processTap() {
    if(phase == TurnPhase.movement && activePlayer == seatId ) {
      selectShips();
    }
    else {
      highlightSystem();
    }
  }

  _processDoubleTap() {
    if(!existsActivatedSystem){
      highlightSystem();
      activateSystem();
    }
    else {
      selectShips();
    }
  }

  activateSystem() {
    ref.read(boardStateProvider.notifier).activateSystem(widget.coordinate);
  }

  highlightSystem() {
    ref.read(boardStateProvider.notifier).selectSystem(widget.coordinate);
  }

  selectShips() {
    ref.read(shipSelectorProvider.notifier).activate(widget.coordinate);
  }
}

class _BoardClick implements BoardClickInterface {
  late final _BoardSpaceState _parent;
  _BoardClick(_BoardSpaceState nS){
    _parent = nS;
  }
  
  @override
  void processDoubleTap() {
    _parent._processDoubleTap();
  }
  
  @override
  void processTap() {
    _parent._processTap();
  }
  
}
