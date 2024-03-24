import 'package:client/board/air_space.dart';
import 'package:client/board/coordinate.dart';
import 'package:client/board/ship_selector_provider.dart';
import 'package:client/board/system.dart';
import 'package:client/model/board_state.dart';
import 'package:client/model/system_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  final Coordinate coordinate;
  final bool activated;
  final bool selected;

  @override
  ConsumerState<BoardSpace> createState() => _BoardSpaceState();
}

class _BoardSpaceState extends ConsumerState<BoardSpace> {
  @override
  Widget build(BuildContext context) {
    Color overlay = const Color.fromARGB(0, 0, 0, 0);
    bool existsActivatedSystem =
        ref.watch(boardStateProvider).activeCoordinate != null;
    if (widget.activated) {
      overlay = const Color.fromARGB(155, 255, 100, 55);
    }
    if (widget.selected) {
      overlay = const Color.fromARGB(155, 255, 255, 0);
    }
    return Stack(
      children: [
        GestureDetector(
          onDoubleTap: !existsActivatedSystem
              ? () => activateSystem()
              : () => selectShips(),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: overlay,
            ),
          ),
        ),
        System(widget.systemState.systemModel),
        AirSpace(ships: widget.systemState.airSpace),
      ],
    );
  }

  activateSystem() {
    ref.read(boardStateProvider.notifier).activateSystem(widget.coordinate);
  }

  selectShips() {
    debugPrint("${widget.systemState.airSpace.length} ships selected.");
    ref.read(shipSelectorProvider.notifier).activate(widget.coordinate);
    //TODO: Create popup to select ships to move

    // ref.read(boardStateProvider.notifier).moveShips(
    //     from: widget.coordinate, ships: [...widget.systemState.airSpace]);
  }
}
