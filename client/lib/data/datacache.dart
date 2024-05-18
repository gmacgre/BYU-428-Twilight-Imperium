import 'package:client/data/planet_data.dart';
import 'package:client/data/ship_data.dart';
import 'package:client/res/coordinate.dart';
import 'package:client/combat/force_makeup.dart';
import 'package:client/data/system_data.dart';
import 'package:client/model/objective.dart';
import 'package:client/model/planet_state.dart';
import 'package:client/model/player.dart';
import 'package:client/model/ship_model.dart';
import 'package:client/model/system_state.dart';
import 'package:client/model/turn_phase.dart';


// NOTE: This class is basically technical debt, but functions as a layer of safety for the program. If no server is reachable, it uses these defaults instead.
// DO NOT REMOVE
class DataCache {
  DataCache._();
  static final DataCache instance = DataCache._();

  String userToken = '';
  int userSeatNumber = 0;

  int activePlayer = 0;

  Coords activeSystem = Coords(0, 0);

  TurnPhase phase = TurnPhase.activation;

  List<Player> players = [
    Player('jol_nar', false, 5, 5, 5, 3, false, 1),
    Player('sol', false, 5, 5, 5, 3, false, 1),
    Player('hacan', false, 5, 5, 5, 3, false, 1),
    Player('l1z1x', false, 5, 5, 5, 3, false, 1),
    Player('letnev', false, 5, 5, 5, 3, false, 1),
    Player('creuss', false, 5, 5, 5, 3, false, 1),
  ];

  List<Objective> publicObjectives = [];

  List<List<SystemState>> boardState = [
    //Column 1
    [
      SystemState(systemModel: SystemData.systemList['Undefined']!,),
      SystemState(systemModel: SystemData.systemList['Undefined']!),
      SystemState(systemModel: SystemData.systemList['Undefined']!),
      SystemState(
        systemModel: SystemData.systemList['Abyz']!,
        airSpace: [
          ShipModel(1, 1, 1, 1, ShipType.fighter),
        ],
        planets: [
          PlanetState(planet: SystemData.systemList['Abyz']!.planets![0], planetOwner: 1, numGroundForces: 3, numPDS: 1, existsSpaceDock: true),
          PlanetState(planet: SystemData.systemList['Abyz']!.planets![1], planetOwner: 3, numGroundForces: 3, numPDS: 2, existsSpaceDock: true)
        ],
        systemOwner: 0
      ),
      SystemState(systemModel: SystemData.systemList['Arinam']!,
      planets: [
        PlanetState(planet: SystemData.systemList['Arinam']!.planets![0], planetOwner: 4, numGroundForces: 2, numPDS: 0, existsSpaceDock: true),
        PlanetState(planet: SystemData.systemList['Arinam']!.planets![1], planetOwner: 5, numGroundForces: 8, numPDS: 1, existsSpaceDock: false)
      ]),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Arnor']!),
    ],
    //Column 2
    [
      SystemState(systemModel: SystemData.systemList['Undefined']!),
      SystemState(systemModel: SystemData.systemList['Undefined']!),
      SystemState(systemModel: SystemData.systemList['Corneeq']!, 
      airSpace: [
        ShipData.defaultData[ShipType.cruiser]!,
        ShipData.defaultData[ShipType.cruiser]!,
      ], systemOwner: 0),
      SystemState(systemModel: SystemData.systemList['Empty']!,
      airSpace: [
        ShipData.defaultData[ShipType.cruiser]!,
        ShipData.defaultData[ShipType.cruiser]!,
      ], systemOwner: 1),
      SystemState(systemModel: SystemData.systemList['Lazar']!,airSpace: [
        ShipData.defaultData[ShipType.cruiser]!,
        ShipData.defaultData[ShipType.cruiser]!,
      ], systemOwner: 2),
      SystemState(systemModel: SystemData.systemList['Empty']!,
      airSpace: [
        ShipData.defaultData[ShipType.cruiser]!,
        ShipData.defaultData[ShipType.cruiser]!,
      ], systemOwner: 3),
      SystemState(systemModel: SystemData.systemList['Lodor']!,
      airSpace: [
        ShipData.defaultData[ShipType.cruiser]!,
        ShipData.defaultData[ShipType.cruiser]!,
      ], systemOwner: 4),
    ],
    //Column 3
    [
      SystemState(systemModel: SystemData.systemList['Undefined']!),
      SystemState(systemModel: SystemData.systemList['Mehar Xull']!,
      airSpace: [
        ShipModel(1, 1, 1, 1, ShipType.cruiser),

      ], systemOwner: 0),
      SystemState(systemModel: SystemData.systemList['Mellon']!,
      airSpace: [
        ShipData.defaultData[ShipType.cruiser]!,
        ShipData.defaultData[ShipType.cruiser]!,
      ], systemOwner: 5),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Bereg']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
    ],
    //Column 4
    [
      SystemState(systemModel: SystemData.systemList['Hercant']!,
      airSpace: [
        ShipModel(1, 1, 1, 1, ShipType.fighter),
        ShipModel(1, 1, 1, 1, ShipType.fighter),
        ShipModel(1, 1, 1, 1, ShipType.flagship),
      ], systemOwner: 0),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Dal Bootha']!),
      SystemState(systemModel: SystemData.systemList['Mecatol Rex']!,
      planets: [
        PlanetState(planet: PlanetData.planets['Mecatol Rex']!, planetOwner: 5, numGroundForces: 0, existsSpaceDock: true, numPDS: 1)
      ]),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Centauri']!),
    ],
    //Column 5
    [
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Archon Ren']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(
        systemModel: SystemData.systemList['Quann']!,
        planets: [ PlanetState(planet: SystemData.systemList['Quann']!.planets![0], exhausted: true, planetOwner: 0, numGroundForces: 1, numPDS: 0, existsSpaceDock: false)]),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Undefined']!),
    ],
    //Column 6
    [
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Creuss']!),
      SystemState(systemModel: SystemData.systemList['Nebula']!),
      SystemState(systemModel: SystemData.systemList['Darien']!,
      planets: [
        PlanetState(planet: SystemData.systemList['Darien']!.planets![0], planetOwner: 2, numGroundForces: 0, numPDS: 2, existsSpaceDock: false)
      ]),
      SystemState(systemModel: SystemData.systemList['CreussGate']!),
      SystemState(systemModel: SystemData.systemList['Undefined']!),
      SystemState(systemModel: SystemData.systemList['Undefined']!),
    ],
    //Column 7
    [
      SystemState(systemModel: SystemData.systemList['Retillion']!),
      SystemState(systemModel: SystemData.systemList['Asteroid']!),
      SystemState(systemModel: SystemData.systemList['Supernova']!),
      SystemState(systemModel: SystemData.systemList['Rift']!),
      SystemState(systemModel: SystemData.systemList['Undefined']!),
      SystemState(systemModel: SystemData.systemList['Undefined']!),
      SystemState(systemModel: SystemData.systemList['Undefined']!),
    ],
  ];


  ForceMakeup allies = ForceMakeup(
    flagship: 1,
    warsun: 1,
    dreadnaught: 3,
    cruiser: 4,
    carrier: 2,
    destroyer: 1,
    fighter: 7
  );
  ForceMakeup enemies = ForceMakeup(
    flagship: 0,
    warsun: 2,
    dreadnaught: 2,
    cruiser: 1,
    carrier: 1,
    destroyer: 1,
    fighter: 5
  );
}
