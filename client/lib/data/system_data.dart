import 'package:client/data/planet_data.dart';

//This differs from the SystemState, it only includes the basic info of a system
class SystemModel {
  List<PlanetModel>? planets;
  Anomaly? anomaly;
  Wormhole? wormhole;
  String? homeSystem;

  SystemModel({this.planets, this.anomaly, this.wormhole, this.homeSystem});
}

enum Wormhole { alpha, beta, delta, gamma }

enum Anomaly { asteroid, nebula, supernova, rift }

class SystemData {
  static final Map<String, SystemModel> systemList = {
    "Mecatol Rex": SystemModel(
      planets: [PlanetData.planets["Mecatol Rex"]!],
    ),
    "Abyz": SystemModel(
      planets: [
        PlanetData.planets["Abyz"]!,
        PlanetData.planets["Fria"]!,
      ],
    ),
    "Arinam": SystemModel(
      planets: [
        PlanetData.planets["Arinam"]!,
        PlanetData.planets["Meer"]!,
      ],
    ),
    "Arnor": SystemModel(
      planets: [
        PlanetData.planets["Arnor"]!,
        PlanetData.planets["Lor"]!,
      ],
    ),
    "Bereg": SystemModel(
      planets: [
        PlanetData.planets["Bereg"]!,
        PlanetData.planets["Lirta IV"]!,
      ],
    ),
    "Centauri": SystemModel(
      planets: [
        PlanetData.planets["Centauri"]!,
        PlanetData.planets["Gral"]!,
      ],
    ),
    "Corneeq": SystemModel(
      planets: [
        PlanetData.planets["Corneeq"]!,
        PlanetData.planets["Resculon"]!,
      ],
    ),
    "Dal Bootha": SystemModel(
      planets: [
        PlanetData.planets["Dal Bootha"]!,
        PlanetData.planets["Xxehan"]!,
      ],
    ),
    "Lazar": SystemModel(
      planets: [
        PlanetData.planets["Lazar"]!,
        PlanetData.planets["Sakulag"]!,
      ],
    ),
    "Lodor": SystemModel(
      planets: [
        PlanetData.planets["Lodor"]!,
      ],
      wormhole: Wormhole.alpha,
    ),
    "Mehar Xull": SystemModel(
      planets: [
        PlanetData.planets["Mehar Xull"]!,
      ],
    ),
    "Mellon": SystemModel(
      planets: [
        PlanetData.planets["Mellon"]!,
        PlanetData.planets["Zohbat"]!,
      ],
    ),
    "New Albion": SystemModel(
      planets: [
        PlanetData.planets["New Albion"]!,
        PlanetData.planets["Starpoint"]!,
      ],
    ),
    "Quann": SystemModel(
      planets: [
        PlanetData.planets["Quann"]!,
      ],
      wormhole: Wormhole.beta,
    ),
    "Qucen'n": SystemModel(
      planets: [
        PlanetData.planets["Qucen'n"]!,
        PlanetData.planets["Rarron"]!,
      ],
    ),
    "Saudor": SystemModel(
      planets: [
        PlanetData.planets["Saudor"]!,
      ],
    ),
    "Tar'Mann": SystemModel(
      planets: [
        PlanetData.planets["Tar'Mann"]!,
      ],
    ),
    "Tequ'ran": SystemModel(
      planets: [
        PlanetData.planets["Tequ'ran"]!,
        PlanetData.planets["Torkan"]!,
      ],
    ),
    "Thibah": SystemModel(
      planets: [
        PlanetData.planets["Thibah"]!,
      ],
    ),
    "Vefut II": SystemModel(
      planets: [
        PlanetData.planets["Vefut II"]!,
      ],
    ),
    "Wellon": SystemModel(
      planets: [
        PlanetData.planets["Wellon"]!,
      ],
    ),
    "Nestphar": SystemModel(
      planets: [
        PlanetData.planets["Nestphar"]!,
      ],
      homeSystem: "Arborec",
    ),
    "Arc Prime": SystemModel(
      planets: [
        PlanetData.planets["Arc Prime"]!,
        PlanetData.planets["Wren Terra"]!,
      ],
      homeSystem: "Letnev",
    ),
    "Lisis II": SystemModel(
      planets: [
        PlanetData.planets["Lisis II"]!,
        PlanetData.planets["Ragh"]!,
      ],
      homeSystem: "Saar",
    ),
    "Muaat": SystemModel(
      planets: [
        PlanetData.planets["Muaat"]!,
      ],
      homeSystem: "Muaat",
    ),
    "Hercant": SystemModel(
      planets: [
        PlanetData.planets["Hercant"]!,
        PlanetData.planets["Arretze"]!,
        PlanetData.planets["Kamdorn"]!,
      ],
      homeSystem: "Hacan",
    ),
    "Jord": SystemModel(
      planets: [
        PlanetData.planets["Jord"]!,
      ],
      homeSystem: "Sol",
    ),
    "Creuss": SystemModel(
      planets: [
        PlanetData.planets["Creuss"]!,
      ],
      wormhole: Wormhole.delta,
      homeSystem: "Creuss",
    ),
    "[0.0.0]": SystemModel(
      planets: [
        PlanetData.planets["[0.0.0]"]!,
      ],
      homeSystem: "L1Z1X",
    ),
    "Moll Primus": SystemModel(
      planets: [
        PlanetData.planets["Moll Primus"]!,
      ],
      homeSystem: "Mentak",
    ),
    "Druaa": SystemModel(
      planets: [
        PlanetData.planets["Druaa"]!,
        PlanetData.planets["Maaluuk"]!,
      ],
      homeSystem: "Naalu",
    ),
    "Mordai II": SystemModel(
      planets: [
        PlanetData.planets["Mordai II"]!,
      ],
      homeSystem: "Nekro",
    ),
    "Tren'Lak": SystemModel(
      planets: [
        PlanetData.planets["Tren'Lak"]!,
        PlanetData.planets["Quinarra"]!,
      ],
      homeSystem: "Sardakk",
    ),
    "Jol": SystemModel(
      planets: [
        PlanetData.planets["Jol"]!,
        PlanetData.planets["Nar"]!,
      ],
      homeSystem: "Jol-Nar",
    ),
    "Winnu": SystemModel(
      planets: [
        PlanetData.planets["Winnu"]!,
      ],
      homeSystem: "Winnu",
    ),
    "Archon Ren": SystemModel(
      planets: [
        PlanetData.planets["Archon Ren"]!,
        PlanetData.planets["Archon Tau"]!,
      ],
      homeSystem: "Xxcha",
    ),
    "Darien": SystemModel(
      planets: [
        PlanetData.planets["Darien"]!,
      ],
      homeSystem: "Yin",
    ),
    "Retillion": SystemModel(
      planets: [
        PlanetData.planets["Retillion"]!,
        PlanetData.planets["Shalloq"]!,
      ],
      homeSystem: "Yssaril",
    ),
    "Asteroid": SystemModel(
      anomaly: Anomaly.asteroid,
    ),
    "Supernova": SystemModel(
      anomaly: Anomaly.supernova,
    ),
    "Rift": SystemModel(
      anomaly: Anomaly.rift,
    ),
    "Nebula": SystemModel(
      anomaly: Anomaly.nebula,
    ),
    "WormholeAlpha": SystemModel(
      wormhole: Wormhole.alpha,
    ),
    "WormholeBeta": SystemModel(
      wormhole: Wormhole.beta,
    ),
    "CreussGate": SystemModel(
      wormhole: Wormhole.delta,
    ),
    "Empty": SystemModel(),
    "Undefined": SystemModel()
  };
}
