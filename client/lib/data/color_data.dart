import 'package:client/data/planet_data.dart';
import 'package:flutter/material.dart';

class ColorData {
  static final List<Color> playerColor = [
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.yellow,
    Colors.black87,
    Colors.orange,
    Colors.pink
  ];

  static final Map<PlanetTrait, Color> traitColor = {
    PlanetTrait.hazardous: Colors.redAccent,
    PlanetTrait.industrial: Colors.greenAccent,
    PlanetTrait.cultural: Colors.blueAccent,
    PlanetTrait.none: Colors.black,
  };
}