import 'package:client/model/player.dart';

class GameState {
  final List<Player> _players = [
    Player("sol", 1, 2, 3, 2, 1),
    Player("jol_nar", 4, 5, 6, 0, 2),
    Player("saar", 7, 8, 9, 9, 3),
    Player("winnu", 9, 9, 9, 1, 4),
    Player("nekro", 7, 1, 4, 9, 5),
    Player("letnev", 5, 5, 5, 1, 6)
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
    //TODO: MAKE THIS ACTUALLY LOOK FOR SCORED AGENDAS
    return -2;
  }
}