import 'package:client/data/system_data.dart';
import 'package:client/model/objective.dart';
import 'package:client/model/player.dart';
import 'package:client/model/system_state.dart';

class DataCache{
  DataCache._();
  static final DataCache instance = DataCache._();

  String userToken = '';

  List<Player> players = [
    Player('jol_nar', false, 5, 5, 5, 3, false, 1),
    Player('jol_nar', false, 5, 5, 5, 3, false, 1),
    Player('jol_nar', false, 5, 5, 5, 3, false, 1),
    Player('jol_nar', false, 5, 5, 5, 3, false, 1),
  ];

  List<Objective> publicObjectives = [];

  List<List<SystemState>> boardState= [
  //Column 1
    [
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Abyz']!),
      SystemState(systemModel: SystemData.systemList['Arinam']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Arnor']!),
    ],
  //Column 2
    [
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Coorneeq']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Lazar']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Lodor']!),
    ],
  //Column 3
    [
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Mehar Xull']!),
      SystemState(systemModel: SystemData.systemList['Mellon']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Bereg']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
    ],
  //Column 4
    [
      SystemState(systemModel: SystemData.systemList['Hercant']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Dal Bootha']!),
      SystemState(systemModel: SystemData.systemList['Mecatol Rex']!),
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
      SystemState(systemModel: SystemData.systemList['Quann']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
    ],
    //Column 6
    [
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Darien']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
    ],
    //Column 7
    [
      SystemState(systemModel: SystemData.systemList['Retillion']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
      SystemState(systemModel: SystemData.systemList['Empty']!),
    ],
  ];

}
