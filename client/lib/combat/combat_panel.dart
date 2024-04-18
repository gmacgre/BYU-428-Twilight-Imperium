import 'package:client/combat/combat_page.dart';
import 'package:client/res/outlined_letters.dart';
import 'package:flutter/material.dart';

class CombatPanel extends StatelessWidget {
  const CombatPanel({
    super.key,
    required this.handler,
    required this.state
  });

  final CombatPanelHandler handler;
  final CombatState state;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 45, 58, 65),
        border: Border.all(color: Colors.amber, width: 5)
      ),
      child: SafeArea(
        child: Center(
          child: _getPanel(state),
        )
      ),
    );
  }

  Widget _getPanel(CombatState state) {
    switch(state) {
      case CombatState.assignHits:
        int hitsToAssign = handler.getHits();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedLetters(content: '$hitsToAssign hits left to assign.'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: hitsToAssign == 0
                    ? MaterialStateProperty.all(Colors.amber.shade300)
                    : MaterialStateProperty.all(Colors.grey),
              ),
              onPressed: (hitsToAssign == 0) ? () => { handler.submitHits() } : null, 
              child: const OutlinedLetters(content: 'Submit Hits'),
            ),
          ],
        );
        
      case CombatState.declareRetreat:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const OutlinedLetters(content: "Do you want to declare a retreat?"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber.shade300)
                    ),
                    onPressed: () => { handler.retreatOrder(true) }, 
                    child: const OutlinedLetters(content: 'Yes'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber.shade300)
                    ),
                    onPressed: () => { handler.retreatOrder(false) }, 
                    child: const OutlinedLetters(content: 'No'),
                  ),
                ),
              ],
            ),
          ],
        );
      case CombatState.enteringCombat:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: OutlinedLetters(content: 'Entering Combat! General Quarters!'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber.shade300)
              ),
              onPressed: () => { handler.swap(CombatState.declareRetreat) }, 
              child: const OutlinedLetters(content: 'All Hands Man Battle Stations!'),
            ),
          ],
        );
      case CombatState.exitingCombat:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: OutlinedLetters(content: 'Combat Ended.'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber.shade300)
              ),
              onPressed: () => { handler.nextPhase() }, 
              child: const OutlinedLetters(content: 'Leave Combat Window'),
            ),
          ],
        );
        
      case CombatState.waiting:
        return const OutlinedLetters(content: 'Waiting...');
    }
  }
}

abstract interface class CombatPanelHandler {
  void swap(CombatState newState);
  void retreatOrder(bool retreating);
  int getHits();
  void submitHits();
  void nextPhase();
}