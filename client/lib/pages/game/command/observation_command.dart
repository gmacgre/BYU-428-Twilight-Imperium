import 'package:client/model/riverpod/board_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ObservationCommandWidget extends ConsumerWidget {
  const ObservationCommandWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int player = ref.read(boardStateProvider).activePlayer;
    return Center(
      child: Text('Waiting for Player ${player + 1}...'),
    );
  }
}