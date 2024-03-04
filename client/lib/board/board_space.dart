import 'package:client/board/air_space.dart';
import 'package:client/board/system.dart';
import 'package:client/model/board_state.dart';
import 'package:client/model/system_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardSpace extends ConsumerWidget {

  const BoardSpace({super.key, required this.systemState, required this.col, required this.row});
  final SystemState systemState;
  final int col;
  final int row;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color overlay = const Color.fromARGB(0, 0, 0, 0);
    if (systemState.activated) {
      overlay = const Color.fromARGB(155, 255, 100, 55);
    }
    return Stack(
      children: [
        GestureDetector(
          onDoubleTap: () => ref.read(boardStateProvider.notifier).activateSystem(col,row),
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
}
