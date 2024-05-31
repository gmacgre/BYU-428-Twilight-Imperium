import 'package:client/data/planet_data.dart';
import 'package:flutter/material.dart';

class ColorData {
  static final List<Color> playerColor = [
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.yellow,
    Colors.black,
    Colors.orange,
    Colors.pink
  ];


  static final List<Color> playerColorFaded = [
    const Color.fromARGB(200, 147, 40, 32),
    const Color.fromARGB(200, 21, 89, 145),
    const Color.fromARGB(200, 79, 20, 90),
    const Color.fromARGB(200, 52, 122, 55),
    const Color.fromARGB(200, 148, 136, 34),
    const Color.fromARGB(150, 0, 0, 0),
    const Color.fromARGB(200, 255, 153, 0),
    const Color.fromARGB(200, 233, 30, 98)
  ];

  static final List<Color> playerColorOutline = [
    Colors.black,
    Colors.black,
    Colors.white,
    Colors.black,
    Colors.black,
    Colors.white,
    Colors.black,
    Colors.black
  ];

  static final Map<PlanetTrait, Color> traitColor = {
    PlanetTrait.hazardous: Colors.redAccent,
    PlanetTrait.industrial: Colors.greenAccent,
    PlanetTrait.cultural: Colors.blueAccent,
    PlanetTrait.none: Colors.black,
  };
}