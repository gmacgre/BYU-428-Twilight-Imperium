import 'package:client/model/riverpod/board_state.dart';
import 'package:client/model/turn_phase.dart';
import 'package:client/pages/game/command/action_command.dart';
import 'package:client/pages/game/command/observation_command.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommandWidget extends ConsumerWidget {
  const CommandWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TurnPhase phase = ref.watch(boardStateProvider).currentPhase;
    

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 4.0),
        color: Colors.blueGrey
      ),
      child: switch(phase) {
        TurnPhase.activation => const ActionCommandWidget(),
        TurnPhase.observation => const ObservationCommandWidget(),
        _ => const Placeholder()
      },
    );    
    
  }  
}