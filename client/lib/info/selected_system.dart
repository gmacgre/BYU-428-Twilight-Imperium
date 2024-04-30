import 'package:client/board/coordinate.dart';
import 'package:client/data/planet_data.dart';
import 'package:client/data/strings.dart';
import 'package:client/data/system_data.dart';
import 'package:client/model/planet_state.dart';
import 'package:client/model/system_state.dart';
import 'package:client/res/outlined_letters.dart';
import 'package:flutter/material.dart';

class SelectedSystem extends StatelessWidget {
  const SelectedSystem({
    required this.coords,
    required this.state,
    super.key
  });

  final Coordinate? coords;
  final SystemState? state;

  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            (state == null) ? Strings.noSystemSelected : _buildSystemName(state!.systemModel),
            style: const TextStyle(
              color: Colors.amber,
              fontFamily: "Handel Gothic D",
              fontSize: 20
            ),
          ),
          Scrollbar(
            controller: controller,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: controller,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _getInfo(state),
              ),
            ),
          )
        ],
      ),
    );
  }

  String _buildSystemName(SystemModel model) {
    if (model.planets == null && model.anomalies == null && model.wormhole == null) {
      return 'Empty Space';
    }
    String toReturn = '';
    if (model.planets != null) {
      for(PlanetModel planet in model.planets!) {
        toReturn += "${planet.name} - ";
      }
      toReturn = toReturn.substring(0, toReturn.length - 3);
      return toReturn;
    }
    return toReturn;
  }
}

List<Widget> _getInfo(SystemState? state) {
  if (state == null) {
    return [ ];
  }
  List<Widget> toReturn = [];
  if (state.systemModel.planets != null) {
    for(int i = 0; i < state.systemModel.planets!.length; i++) {
      toReturn.add(PlanetInfo(planet: state.systemModel.planets![i], state: state.planets![i]));
    }
  }
  return toReturn.map((e) => Padding(padding: const EdgeInsets.all(8.0), child: e,)).toList();
}

class PlanetInfo extends StatelessWidget {
  const PlanetInfo({
    super.key,
    this.planet,
    this.state  
  });

  final PlanetModel? planet;
  final PlanetState? state; 

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
      color: Colors.amber,
      fontFamily: "Handel Gothic D",
      fontSize: 14
    );
    PlanetModel toUse;
    PlanetState fullState;
    if (planet == null) {
      toUse = PlanetData.planets['null']!;
      fullState = PlanetState(planet: toUse);
    }
    else {
      toUse = planet!;
      fullState = state!;
    }
    return SizedBox(
      width: 100,
      height: 150,
      child: Column(
        children: [
          OutlinedLetters(content: toUse.name),
          ConstrainedBox(
            constraints: BoxConstraints.tight(const Size(80, 80)),
            child: MouseRegion(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(40),
                    color: (fullState.exhausted) ? Colors.grey : toUse.color,
                    border: Border.all(
                      //This will be set to the controlling player's color
                      color: Colors.black,
                      width: 5
                    )),
              ),
            ),
          ),
          Text('Resources: ${toUse.resources}', style: style,),
          Text('Influence: ${toUse.influence}', style: style,),
        ],
      ),
    );
  }
}