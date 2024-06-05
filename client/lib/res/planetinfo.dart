import 'package:client/data/color_data.dart';
import 'package:client/data/planet_data.dart';
import 'package:client/data/strings.dart';
import 'package:client/model/planet_state.dart';
import 'package:client/res/hover_tip.dart';
import 'package:client/res/outlined_letters.dart';
import 'package:flutter/material.dart';

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
      fullState = PlanetState(planet: toUse, planetOwner: -1, numGroundForces: 0, numPDS: 0, existsSpaceDock: false);
    }
    else {
      toUse = planet!;
      fullState = state!;
    }
    return Column(
      children: [
        OutlinedLetters(content: toUse.name),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(40),
              color: (fullState.planetOwner != -1) ? ColorData.playerColor[fullState.planetOwner] : Colors.white,
              border: Border.all(
                color: ColorData.traitColor[toUse.trait]!,
                width: 5
              )),
          child: (fullState.exhausted) ? 
            const HoverTip(message: Strings.exhausted, child: Icon(Icons.access_time, size: 40.0, color: Colors.white,)) : 
            const HoverTip(message: Strings.ready, child: Icon(Icons.check, size: 40.0, color: Colors.white,))
        ),
        Text('Resources: ${toUse.resources}', style: style,),
        Text('Influence: ${toUse.influence}', style: style,),
        Text(Strings.planetTrait[toUse.trait]!, style: style,),
      ],
    );
  }
}