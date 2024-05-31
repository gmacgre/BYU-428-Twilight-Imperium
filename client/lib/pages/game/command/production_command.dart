import 'package:client/model/riverpod/board_state.dart';
import 'package:client/model/system_state.dart';
import 'package:client/res/outlined_letters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductionCommandWidget extends ConsumerWidget {
  const ProductionCommandWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemState state = ref.read(boardStateProvider).activeSystemState!;
    
    if( state.planets == null || 
        state.planets!.isEmpty) {
      return _buildCannotProduce(ref);
    }

    return const Placeholder();
  }

  Widget _buildCannotProduce(WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Active System Cannot Produce.'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () => {_endProduction(ref)}, child: const OutlinedLetters(content: 'End Turn')),
          )
        ]
      ),
    );
  }


  void _endProduction(WidgetRef ref) {
    ref.read(boardStateProvider.notifier).endTurn();
  }
}