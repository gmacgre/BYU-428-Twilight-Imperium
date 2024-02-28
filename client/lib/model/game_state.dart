import 'package:client/model/objective.dart';
import 'package:client/model/player.dart';

class GameState {
  final List<Player> _players = [
    Player("sol", 1, 2, 3, 2, 3),
    Player("jol_nar", 4, 5, 6, 0, 4),
    Player("saar", 7, 8, 9, 9, 5),
    Player("winnu", 9, 9, 9, 1, 8),
    Player("nekro", 7, 1, 4, 9, 7),
    Player("letnev", 5, 5, 5, 1, 6)
  ];

  final List<Objective> _publicObjectives = [
    Objective(1, {2,5,1,0}, 1),
    Objective(2, {3,1,0}, 1),
    Objective(3, {4,1,0}, 1),
    Objective(4, {2}, 1),
    Objective(5, {2,5,1,0}, 1),
    Objective(6, {2,5,1,0}, 2),
    Objective(7, {2,5,1,0}, 2),
    Objective(8, {2,5,1,0}, 2),
    Objective(9, {2,5,1,0}, 2),
    Objective(0, {2,5,1,0}, 2),
  ];

  int getNumPlayers() {
    return _players.length;
  }

  Player getPlayer(int idx) {
    if(idx < 0 || idx >= _players.length) {
      return Player("yssaril", -1, -1, -1, -1, -1);
    }
    return _players[idx];
  }

  int getObjScoredCount(int idx) {
    int toReturn = 0;
    for(int i = 0; i < _publicObjectives.length; i++) {
      if(_publicObjectives[i].hasCompleted(idx)) {
        toReturn++;
      }
    }
    return toReturn;
  }

  List<Objective> getPublicObjectives() {
    return _publicObjectives;
  }
}