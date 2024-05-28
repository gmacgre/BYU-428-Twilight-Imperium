import 'package:client/data/color_data.dart';
import 'package:client/data/strings.dart';
import 'package:client/model/riverpod/board_state.dart';
import 'package:client/model/ship_model.dart';
import 'package:client/pages/game/board/ship_selector_provider.dart';
import 'package:client/res/coordinate.dart';
import 'package:client/res/outlined_letters.dart';
import 'package:client/res/unit_tokens/carrier.dart';
import 'package:client/res/unit_tokens/cruiser.dart';
import 'package:client/res/unit_tokens/destroyer.dart';
import 'package:client/res/unit_tokens/dreadnaught.dart';
import 'package:client/res/unit_tokens/fighter.dart';
import 'package:client/res/unit_tokens/flagship.dart';
import 'package:client/res/unit_tokens/war_sun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovementCommandWidget extends ConsumerStatefulWidget {
  const MovementCommandWidget({super.key});

  @override
  ConsumerState<MovementCommandWidget> createState() => _MovementCommandWidgetState();
}

class _MovementCommandWidgetState extends ConsumerState<MovementCommandWidget> {

  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

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
    List<ShipModel>? selectedShips = ref.watch(shipSelectorProvider).selectedShips[selectedCoordinates];
    List<ShipModel> shipsToDisplay = ref.read(boardStateProvider).systemStates[selectedCoordinates.x][selectedCoordinates.y].airSpace;

    return _finalBuild(
      LayoutBuilder(
        builder: (context, constraints) => Scrollbar(
          thumbVisibility: true,
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: shipsToDisplay.map((e) => 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SelectableShip(model: e, owner: activePlayer, height: constraints.maxHeight * 0.5),
                    ]
                  ),
                )
              ).toList()
            ),
          ),
        ),
      ),
    );
  }

  Widget _finalBuild(Widget internal) {
    return Row(
      children: [
        Expanded(
          flex: 17,
          child: internal
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4,0,4,0),
            child: ElevatedButton(
              onPressed: () => {_submitMoves()},
              child: const OutlinedLetters(content: Strings.submitMoves)
            ),
          )
        )
      ],
    );
  }

  Widget _buildOtherPlayerSystemSelected() {
    return _finalBuild(
      const Center(
        child: Text('Selected System owned by another Player!')
      )
    );
  }

  Widget _buildNoSystemSelected() {
    return _finalBuild(
      const Center(
        child: Text('Select a system to add ships to movement')
      )
    );
  }

  Widget _buildOutOfRangeSystemSelected() {
    return _finalBuild(
      const Center(
        child: Text('No ships can reach activated system from here.')
      )
    );
  }
  
  void _submitMoves() {}
}

class _SelectableShip extends StatelessWidget {
  final ShipModel model;
  final int owner;
  final double height;
  const _SelectableShip({
    required this.model,
    required this.owner,
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    Color outline = ColorData.playerColorOutline[owner];
    Color fill = ColorData.playerColor[owner];
    return switch(model.type) {
      ShipType.flagship => FlagshipIcon(
        outline: outline,
        fill: fill,
        combat: model.combat,
        move: model.movement,
        capacity: model.capacity,
        cost: model.cost,
        width: height * 2, 
        height: height
      ),
      ShipType.warsun => WarSunIcon(
        outline: outline,
        fill: fill,
        combat: model.combat,
        move: model.movement,
        capacity: model.capacity,
        cost: model.cost,
        width: height, 
        height: height
      ),
      ShipType.dreadnought => DreadnaughtIcon(
        outline: outline,
        fill: fill,
        combat: model.combat,
        move: model.movement,
        capacity: model.capacity,
        cost: model.cost,
        width: height * 2, 
        height: height
      ),
      ShipType.carrier => CarrierIcon(
        outline: outline,
        fill: fill,
        combat: model.combat,
        move: model.movement,
        capacity: model.capacity,
        cost: model.cost,
        width: height * 2, 
        height: height
      ),
      ShipType.cruiser => CruiserIcon(
        outline: outline,
        fill: fill,
        combat: model.combat,
        move: model.movement,
        capacity: model.capacity,
        cost: model.cost,
        width: height * 2, 
        height: height
      ),
      ShipType.destroyer => DestroyerIcon(
        outline: outline,
        fill: fill,
        combat: model.combat,
        move: model.movement,
        capacity: model.capacity,
        cost: model.cost,
        width: height * 1.5, 
        height: height
      ),
      ShipType.fighter => FighterIcon(
        outline: outline,
        fill: fill,
        combat: model.combat,
        move: model.movement,
        capacity: model.capacity,
        cost: model.cost,
        width: height, 
        height: height
      )
    };
  }
}