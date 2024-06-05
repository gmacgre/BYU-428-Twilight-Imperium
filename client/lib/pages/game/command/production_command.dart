import 'package:client/data/planet_data.dart';
import 'package:client/model/planet_state.dart';
import 'package:client/model/riverpod/board_state.dart';
import 'package:client/model/system_state.dart';
import 'package:client/res/outlined_letters.dart';
import 'package:client/res/pair.dart';
import 'package:client/res/planetinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductionCommandWidget extends ConsumerStatefulWidget {
  const ProductionCommandWidget({super.key});

  @override
  ConsumerState<ProductionCommandWidget> createState() => _ProductionCommandWidgetState();
}

class _ProductionCommandWidgetState extends ConsumerState<ProductionCommandWidget> {

  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemState state = ref.read(boardStateProvider).activeSystemState!;
    int activePlayer = ref.read(boardStateProvider).activePlayer;
    
    if( state.planets == null || 
        state.planets!.isEmpty ||
        state.systemOwner != activePlayer) {
      return _buildCannotProduce(ref);
    }

    bool hasWorkingSpacedock = state.planets!.fold(false, (previousValue, element) => (element.existsSpaceDock && element.planetOwner == activePlayer)? true: previousValue);

    if(!hasWorkingSpacedock){
      return _buildCannotProduce(ref);
    }

    return _buildProductionWindow(ref, activePlayer);
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

  Widget _buildProductionWindow(WidgetRef ref, int player) {
    List<Pair<PlanetState, PlanetModel>> planets = ref.read(boardStateProvider.notifier).getOwnedPlanets(player);
    
    return LayoutBuilder(
      builder: (context, constraints) => Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: Row(
            children: planets.map((e) => _buildSelectablePlanet(e.first, e.second, constraints)).toList()
          ),
        )
      ),
    );
  }


  void _endProduction(WidgetRef ref) {
    ref.read(boardStateProvider.notifier).endTurn();
  }
  
  Widget _buildSelectablePlanet(PlanetState first, PlanetModel second, BoxConstraints constraints) {
    return PlanetInfo(planet: second, state: first,);
  }
}