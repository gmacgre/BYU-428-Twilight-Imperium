import 'dart:ui';

import 'package:flutter/material.dart';

class PlanetModel {
  final String name;
  final int resources;
  final int influence;
  final Tech techColor;
  final PlanetTrait trait;
  final Color color;

  PlanetModel(
      {required this.name,
      required this.resources,
      required this.influence,
      this.techColor = Tech.none,
      this.trait = PlanetTrait.none,
      required this.color});
}

enum PlanetTrait {
  hazardous,
  industrial,
  cultural,
  none,
}

enum Tech {
  red,
  green,
  blue,
  yellow,
  none,
}

//https://twilight-imperium.fandom.com/wiki/Planet_Systems
class PlanetData {
  static final Map<String, PlanetModel> planets = {
    "Mecatol Rex": PlanetModel(
      name: "Mecatol Rex",
      resources: 1,
      influence: 6,
      color: const Color.fromRGBO(145, 145, 145, 1),
    ),
    "Abyz": PlanetModel(
      name: "Abyz",
      resources: 3,
      influence: 0,
      trait: PlanetTrait.hazardous,
      color: const Color.fromRGBO(33, 167, 62, 1),
    ),
    "Fria": PlanetModel(
      name: "Fria",
      resources: 2,
      influence: 0,
      trait: PlanetTrait.hazardous,
      color: const Color.fromRGBO(192, 216, 215, 1),
    ),
    "Arinam": PlanetModel(
      name: "Arinam",
      resources: 1,
      influence: 2,
      trait: PlanetTrait.industrial,
      color: const Color.fromRGBO(151, 21, 238, 1),
    ),
    "Meer": PlanetModel(
      name: "Meer",
      resources: 0,
      influence: 4,
      trait: PlanetTrait.hazardous,
      techColor: Tech.red,
      color: const Color.fromRGBO(255, 81, 0, 1),
    ),
    "Arnor": PlanetModel(
      name: "Arnor",
      resources: 2,
      influence: 1,
      trait: PlanetTrait.industrial,
      color: const Color.fromRGBO(4, 129, 15, 1),
    ),
    "Lor": PlanetModel(
      name: "Lor",
      resources: 1,
      influence: 2,
      trait: PlanetTrait.industrial,
      color: const Color.fromRGBO(182, 93, 41, 1),
    ),
    "Bereg": PlanetModel(
      name: "Bereg",
      resources: 3,
      influence: 1,
      trait: PlanetTrait.hazardous,
      color: const Color.fromRGBO(140, 179, 211, 1),
    ),
    "Lirta IV": PlanetModel(
      name: "Lirta IV",
      resources: 2,
      influence: 3,
      trait: PlanetTrait.hazardous,
      color: const Color.fromRGBO(33, 100, 1, 1),
    ),
    "Centauri": PlanetModel(
      name: "Centauri",
      resources: 1,
      influence: 3,
      trait: PlanetTrait.cultural,
      color: const Color.fromRGBO(123, 83, 146, 1),
    ),
    "Gral": PlanetModel(
      name: "Gral",
      resources: 1,
      influence: 1,
      trait: PlanetTrait.industrial,
      techColor: Tech.blue,
      color: const Color.fromRGBO(1, 223, 156, 1),
    ),
    "Corneeq": PlanetModel(
      name: "Corneeq",
      resources: 1,
      influence: 2,
      trait: PlanetTrait.cultural,
      color: const Color.fromRGBO(26, 64, 121, 1),
    ),
    "Resculon": PlanetModel(
      name: "Resculon",
      resources: 2,
      influence: 0,
      trait: PlanetTrait.cultural,
      color: const Color.fromRGBO(161, 155, 95, 1),
    ),
    "Dal Bootha": PlanetModel(
      name: "Dal Bootha",
      resources: 0,
      influence: 2,
      trait: PlanetTrait.cultural,
      color: const Color.fromRGBO(37, 100, 47, 1),
    ),
    "Xxehan": PlanetModel(
      name: "Xxehan",
      resources: 1,
      influence: 1,
      trait: PlanetTrait.cultural,
      color: const Color.fromRGBO(25, 131, 34, 1),
    ),
    "Lazar": PlanetModel(
      name: "Lazar",
      resources: 1,
      influence: 0,
      trait: PlanetTrait.industrial,
      techColor: Tech.yellow,
      color: const Color.fromRGBO(221, 135, 185, 1),
    ),
    "Sakulag": PlanetModel(
      name: "Sakulag",
      resources: 2,
      influence: 1,
      trait: PlanetTrait.hazardous,
      color: const Color.fromRGBO(1, 87, 9, 1),
    ),
    "Lodor": PlanetModel(
      name: "Lodor",
      resources: 3,
      influence: 1,
      trait: PlanetTrait.cultural,
      color: const Color.fromRGBO(171, 187, 114, 1),
    ),
    "Mehar Xull": PlanetModel(
      name: "Mehar Xull",
      resources: 1,
      influence: 3,
      trait: PlanetTrait.hazardous,
      techColor: Tech.red,
      color: const Color.fromRGBO(148, 163, 113, 1),
    ),
    "Mellon": PlanetModel(
      name: "Mellon",
      resources: 0,
      influence: 2,
      trait: PlanetTrait.cultural,
      color: const Color.fromRGBO(8, 207, 124, 1),
    ),
    "Zohbat": PlanetModel(
      name: "Zohbat",
      resources: 3,
      influence: 1,
      trait: PlanetTrait.hazardous,
      color: const Color.fromRGBO(74, 107, 102, 1),
    ),
    "New Albion": PlanetModel(
      name: "New Albion",
      resources: 1,
      influence: 1,
      trait: PlanetTrait.industrial,
      techColor: Tech.green,
      color: const Color.fromRGBO(29, 160, 3, 1),
    ),
    "Starpoint": PlanetModel(
      name: "Starpoint",
      resources: 3,
      influence: 1,
      trait: PlanetTrait.hazardous,
      color: const Color.fromRGBO(66, 88, 46, 1),
    ),
    "Quann": PlanetModel(
      name: "Quann",
      resources: 2,
      influence: 1,
      trait: PlanetTrait.cultural,
      color: const Color.fromRGBO(56, 122, 11, 1),
    ),
    "Qucen'n": PlanetModel(
      name: "Qucen'n",
      resources: 1,
      influence: 2,
      trait: PlanetTrait.industrial,
      color: const Color.fromRGBO(6, 116, 6, 1),
    ),
    "Rarron": PlanetModel(
      name: "Rarron",
      resources: 0,
      influence: 3,
      trait: PlanetTrait.cultural,
      color: const Color.fromRGBO(199, 125, 55, 1),
    ),
    "Saudor": PlanetModel(
      name: "Saudor",
      resources: 2,
      influence: 2,
      trait: PlanetTrait.industrial,
      color: const Color.fromRGBO(10, 53, 23, 1),
    ),
    "Tar'Mann": PlanetModel(
      name: "Tar'Mann",
      resources: 1,
      influence: 1,
      trait: PlanetTrait.industrial,
      techColor: Tech.green,
      color: const Color.fromRGBO(9, 95, 1, 1),
    ),
    "Tequ'ran": PlanetModel(
      name: "Tequ'ran",
      resources: 2,
      influence: 0,
      trait: PlanetTrait.hazardous,
      color: const Color.fromRGBO(145, 101, 52, 1),
    ),
    "Torkan": PlanetModel(
      name: "Torkan",
      resources: 0,
      influence: 3,
      trait: PlanetTrait.cultural,
      color: const Color.fromRGBO(190, 79, 79, 1),
    ),
    "Thibah": PlanetModel(
      name: "Thibah",
      resources: 1,
      influence: 1,
      trait: PlanetTrait.industrial,
      techColor: Tech.blue,
      color: const Color.fromRGBO(155, 62, 39, 1),
    ),
    "Vefut II": PlanetModel(
      name: "Vefut II",
      resources: 2,
      influence: 2,
      trait: PlanetTrait.hazardous,
      color: const Color.fromRGBO(71, 38, 80, 1),
    ),
    "Wellon": PlanetModel(
      name: "Wellon",
      resources: 1,
      influence: 2,
      trait: PlanetTrait.industrial,
      techColor: Tech.yellow,
      color: const Color.fromRGBO(228, 144, 48, 1),
    ),
    "Nestphar": PlanetModel(
      name: "Nestphar",
      resources: 3,
      influence: 2,
      color: const Color.fromRGBO(186, 228, 2, 1),
    ),
    "Arc Prime": PlanetModel(
      name: "Arc Prime",
      resources: 4,
      influence: 0,
      color: const Color.fromRGBO(56, 71, 57, 1),
    ),
    "Wren Terra": PlanetModel(
      name: "Wren Terra",
      resources: 2,
      influence: 1,
      color: const Color.fromRGBO(1, 110, 1, 1),
    ),
    "Lisis II": PlanetModel(
      name: "Lisis II",
      resources: 1,
      influence: 0,
      color: const Color.fromRGBO(163, 182, 117, 1),
    ),
    "Ragh": PlanetModel(
      name: "Ragh",
      resources: 2,
      influence: 1,
      color: const Color.fromRGBO(204, 176, 152, 1),
    ),
    "Muaat": PlanetModel(
      name: "Muaat",
      resources: 4,
      influence: 1,
      color: const Color.fromRGBO(150, 27, 11, 1),
    ),
    "Hercant": PlanetModel(
      name: "Hercant",
      resources: 1,
      influence: 1,
      color: const Color.fromRGBO(179, 115, 20, 1),
    ),
    "Arretze": PlanetModel(
      name: "Arretze",
      resources: 2,
      influence: 0,
      color: const Color.fromRGBO(214, 212, 91, 1),
    ),
    "Kamdorn": PlanetModel(
      name: "Kamdorn",
      resources: 0,
      influence: 1,
      color: const Color.fromRGBO(160, 93, 54, 1),
    ),
    "Jord": PlanetModel(
      name: "Jord",
      resources: 4,
      influence: 2,
      color: const Color.fromRGBO(4, 16, 180, 1),
    ),
    "Creuss": PlanetModel(
      name: "Creuss",
      resources: 4,
      influence: 2,
      color: const Color.fromRGBO(131, 199, 255, 1),
    ),
    "[0.0.0]": PlanetModel(
      name: "[0.0.0]",
      resources: 5,
      influence: 0,
      color: const Color.fromRGBO(35, 53, 42, 1),
    ),
    "Moll Primus": PlanetModel(
      name: "Moll Primus",
      resources: 4,
      influence: 1,
      color: const Color.fromRGBO(161, 130, 27, 1),
    ),
    "Druaa": PlanetModel(
      name: "Druaa",
      resources: 3,
      influence: 1,
      color: const Color.fromRGBO(34, 128, 49, 1),
    ),
    "Maaluuk": PlanetModel(
      name: "Maaluuk",
      resources: 0,
      influence: 2,
      color: const Color.fromRGBO(182, 92, 7, 1),
    ),
    "Mordai II": PlanetModel(
      name: "Mordai II",
      resources: 4,
      influence: 0,
      color: const Color.fromRGBO(83, 47, 47, 1),
    ),
    "Tren'Lak": PlanetModel(
      name: "Tren'Lak",
      resources: 1,
      influence: 0,
      color: const Color.fromRGBO(128, 119, 119, 1),
    ),
    "Quinarra": PlanetModel(
      name: "Quinarra",
      resources: 3,
      influence: 1,
      color: const Color.fromRGBO(228, 70, 70, 1),
    ),
    "Jol": PlanetModel(
      name: "Jol",
      resources: 1,
      influence: 2,
      color: const Color.fromRGBO(24, 120, 145, 1),
    ),
    "Nar": PlanetModel(
      name: "Nar",
      resources: 2,
      influence: 3,
      color: const Color.fromRGBO(7, 80, 177, 1),
    ),
    "Winnu": PlanetModel(
      name: "Winnu",
      resources: 3,
      influence: 4,
      color: const Color.fromRGBO(187, 78, 51, 1),
    ),
    "Archon Ren": PlanetModel(
      name: "Archon Ren",
      resources: 2,
      influence: 3,
      color: const Color.fromRGBO(44, 121, 0, 1),
    ),
    "Archon Tau": PlanetModel(
      name: "Archon Tau",
      resources: 1,
      influence: 1,
      color: const Color.fromRGBO(59, 83, 4, 1),
    ),
    "Darien": PlanetModel(
      name: "Darien",
      resources: 4,
      influence: 4,
      color: const Color.fromRGBO(211, 201, 112, 1),
    ),
    "Retillion": PlanetModel(
      name: "Retillion",
      resources: 2,
      influence: 3,
      color: const Color.fromRGBO(3, 87, 40, 1),
    ),
    "Shalloq": PlanetModel(
      name: "Shalloq",
      resources: 1,
      influence: 2,
      color: const Color.fromRGBO(38, 100, 57, 1),
    ),
    'null': PlanetModel(
      name: 'Unselected',
      resources: 0,
      influence: 0,
      color: Colors.grey
    )
  };
}
