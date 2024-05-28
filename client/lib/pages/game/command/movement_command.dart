import 'package:client/model/riverpod/board_state.dart';
import 'package:client/model/ship_model.dart';
import 'package:client/pages/game/board/ship_selector_provider.dart';
import 'package:client/res/coordinate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovementCommandWidget extends ConsumerStatefulWidget {
  const MovementCommandWidget({super.key});

  @override
  ConsumerState<MovementCommandWidget> createState() => _MovementCommandWidgetState();
}

class _MovementCommandWidgetState extends ConsumerState<MovementCommandWidget> {

  @override
  Widget build(BuildContext context) {
    
    Coords? selectedCoordinates = ref.watch(boardStateProvider).selectedCoordinate;
    if(selectedCoordinates == null || selectedCoordinates == ref.read(boardStateProvider).activeCoordinate) {
      return _buildNoSystemSelected();
    }
    int activePlayer = ref.read(boardStateProvider).activePlayer;
    if(ref.read(boardStateProvider).systemStates[selectedCoordinates.x][selectedCoordinates.y].systemOwner != activePlayer) {
      return _buildOtherPlayerSystemSelected();
    }
    if(!ref.read(boardStateProvider).highlightSet.contains(selectedCoordinates)) {
      return _buildOutOfRangeSystemSelected();
    }
    Map<Coords, List<ShipModel>> selectedShips = ref.watch(shipSelectorProvider).selectedShips;
    List<ShipModel> shipsToDisplay = ref.read(boardStateProvider).systemStates[selectedCoordinates.x][selectedCoordinates.y].airSpace;
    return const Placeholder();
  }

  Widget _buildOtherPlayerSystemSelected() {
    return const Center(
      child: Text('Selected System owned by another Player!')
    );
  }

  Widget _buildNoSystemSelected() {
    return const Center(
      child: Text('Select a system to move ships from.')
    );
  }

  Widget _buildOutOfRangeSystemSelected() {
    return const Center(
      child: Text('Ships in System Cannot Reach Activated System.')
    );
  }
}