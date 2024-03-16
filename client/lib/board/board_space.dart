import 'package:client/board/air_space.dart';
import 'package:client/board/coordinate.dart';
import 'package:client/board/system.dart';
import 'package:client/model/board_state.dart';
import 'package:client/model/system_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardSpace extends ConsumerWidget {
  const BoardSpace(
      {super.key,
      required this.systemState,
      required this.coordinate,
      required this.activated});
  final SystemState systemState;
  final Coordinate coordinate;
  final bool activated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color overlay = const Color.fromARGB(0, 0, 0, 0);
    bool existsActivatedSystem =
        ref.watch(boardStateProvider).activeCoordinate != null;
    if (activated) {
      overlay = const Color.fromARGB(155, 255, 100, 55);
    }
    return Stack(
      children: [
        GestureDetector(
          onDoubleTap: !existsActivatedSystem
              ? () => activateSystem(ref)
              : () => selectShips(ref),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: overlay,
            ),
          ),
        ),
        System(systemState.systemModel),
        AirSpace(ships: systemState.airSpace),
      ],
    );
  }

  activateSystem(ref) {
    ref.read(boardStateProvider.notifier).activateSystem(coordinate);
  }

  selectShips(ref) {
    debugPrint("${systemState.airSpace.length} ships selected.");
    //TODO: Create popup to select ships to move
    ref.read(boardStateProvider.notifier).moveShips(coordinate, [...systemState.airSpace]);
  }
}
