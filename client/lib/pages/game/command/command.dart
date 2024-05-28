import 'package:client/data/color_data.dart';
import 'package:client/data/strings.dart';
import 'package:client/model/riverpod/board_state.dart';
import 'package:client/model/riverpod/player_state.dart';
import 'package:client/model/turn_phase.dart';
import 'package:client/pages/game/command/action_command.dart';
import 'package:client/pages/game/command/movement_command.dart';
import 'package:client/pages/game/command/observation_command.dart';
import 'package:client/pages/game/command/production_command.dart';
import 'package:client/res/outlined_letters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommandWidget extends ConsumerWidget {
  const CommandWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TurnPhase phase = ref.watch(boardStateProvider).currentPhase;
    int ap = ref.watch(boardStateProvider).activePlayer;
    String apRace = ref.watch(playerStateProvider).players[ap].getName();
    String phaseName = Strings.phaseDisplayName[phase]!;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 4.0),
        color: Colors.blueGrey
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [              
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: switch(phase) {
                      TurnPhase.observation => const ObservationCommandWidget(),
                      TurnPhase.activation => const ActionCommandWidget(),
                      TurnPhase.movement => const MovementCommandWidget(),
                      TurnPhase.production => const ProductionCommandWidget(),
                      _ => const Placeholder()
                    },
                  ),
                ),
                // Active Player Icon
                Container(
                  decoration: BoxDecoration(
                    color: ColorData.playerColor[ap],
                    border: Border.all(color: ColorData.playerColor[ap])
                  ),
                  height: constraints.maxHeight * 0.8,
                  width: constraints.maxHeight * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,constraints.maxHeight * 0.05,0,0),
                        child: Text(
                          'Turn:',
                          style: TextStyle(
                            fontSize: constraints.maxHeight * 0.13,
                            color: ColorData.playerColorOutline[ap],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,0,0,constraints.maxHeight * 0.05),
                        child: Image.asset(
                          Strings.raceIcon(apRace),
                          height: constraints.maxHeight * 0.5,
                          width: constraints.maxHeight * 0.5,
                        ),
                      )
                    ],
                  ),
                )
              ]
            ),
            CustomPaint(
              painter: _TurnPhaseIndicatorPainter(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0,6,12,6),
                child: OutlinedLetters(content: phaseName),
              ),
            )
          ]
        ),
      ),
    );    
    
  }  
}

class _TurnPhaseIndicatorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path p = Path();
    p.moveTo(0.0, 0.0);
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width * 0.9, size.height);
    p.lineTo(0.0, size.height);
    p.lineTo(0.0, 0.0);
    canvas.drawPath(p, Paint()..color=Colors.grey);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}