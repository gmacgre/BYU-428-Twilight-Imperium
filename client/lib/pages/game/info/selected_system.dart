
import 'package:client/res/coordinate.dart';
import 'package:client/data/planet_data.dart';
import 'package:client/data/strings.dart';
import 'package:client/data/system_data.dart';
import 'package:client/model/system_state.dart';
import 'package:client/res/planetinfo.dart';
import 'package:flutter/material.dart';

class SelectedSystem extends StatelessWidget {
  const SelectedSystem({
    required this.coords,
    required this.state,
    super.key
  });

  final Coords? coords;
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
    if (model.homeSystem != null && model.homeSystem == 'Undefined') {
      return 'Unselected Home System';
    }
    if (model.planets == null && model.anomaly == null && model.wormhole == null) {
      return 'Empty Space';
    }
    String toReturn = '';
    if (model.planets != null) {
      for(PlanetModel planet in model.planets!) {
        toReturn += "${planet.name} - ";
      }
      toReturn = toReturn.substring(0, toReturn.length - 3);
    }
    if (model.anomaly != null) {
      return Strings.anomalyDisplayName[model.anomaly]!;
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

