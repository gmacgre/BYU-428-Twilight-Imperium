import 'package:client/data/planet_data.dart';
import 'package:flutter/material.dart';

class ColorData {
  static final List<Color> playerColor = [
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.black87,
  ];

  static final Map<PlanetTrait, Color> traitColor = {
    PlanetTrait.hazardous: Colors.redAccent,
    PlanetTrait.industrial: Colors.greenAccent,
    PlanetTrait.cultural: Colors.blueAccent,
    PlanetTrait.none: Colors.black,
  };
}