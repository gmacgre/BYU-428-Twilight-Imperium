import 'package:client/data/strings.dart';
import 'package:client/model/riverpod/board_state.dart';
import 'package:client/model/turn_phase.dart';
import 'package:client/res/coordinate.dart';
import 'package:client/res/outlined_letters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommandWidget extends ConsumerWidget {
  const CommandWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TurnPhase phase = ref.watch(boardStateProvider).currentPhase;
    Coords? selectedCoordinate = ref.watch(boardStateProvider).selectedCoordinate;
    String phaseString = phase.toString().split('.').last.toUpperCase();

    
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 32,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey),
            color: Colors.grey,
          ),
          child: Center(
            child: DefaultTextStyle(
              // This is needed because for some reason there is an underline on the text
              // applied by the default style.
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              child: OutlinedLetters(
                content: phaseString,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 32,
            width: 140,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: _getButtonHighlight(phase, selectedCoordinate) 
                  ? MaterialStateProperty.all(Colors.amber.shade300)
                  : MaterialStateProperty.all(Colors.grey),
            ),
            onPressed: () {
              ref.read(boardStateProvider.notifier).endPhase();
            },
            child: OutlinedLetters(
                content: phase == TurnPhase.production
                    ? Strings.endTurn
                    : Strings.nextPhase),
          ),
        ),
      ],
    );
    return const Placeholder();
  }

  bool _getButtonHighlight(TurnPhase phase, Coords? selected) {
    if (phase == TurnPhase.production || phase == TurnPhase.movement) {
      return true;
    }
    if (phase == TurnPhase.activation && selected != null) {
      return true;
    }
    return false;
  }
}