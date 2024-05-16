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

  static final List<Color> playerAirspaceColor = [
    const Color.fromARGB(100, 244, 67, 54),
    const Color.fromARGB(100, 33, 149, 243),
    const Color.fromARGB(100, 155, 39, 176),
    const Color.fromARGB(100, 76, 175, 79),
    const Color.fromARGB(100, 255, 235, 59),
    const Color.fromARGB(100, 0, 0, 0),
    const Color.fromARGB(100, 255, 153, 0),
    const Color.fromARGB(100, 233, 30, 98)
  ];

  static final Map<PlanetTrait, Color> traitColor = {
    PlanetTrait.hazardous: Colors.redAccent,
    PlanetTrait.industrial: Colors.greenAccent,
    PlanetTrait.cultural: Colors.blueAccent,
    PlanetTrait.none: Colors.black,
  };
}