import 'package:client/data/datacache.dart';
import 'package:client/model/player.dart';
import 'package:client/model/request_response/update/new_player.dart';
import 'package:client/model/request_response/update/update.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_state.g.dart';

@riverpod
class PlayerState extends _$PlayerState {

  @override
  PlayerStateObject build() {
    return PlayerStateObject(players: DataCache.instance.players);
  }

  void setState(List<Player> newPlayers) {
    state = PlayerStateObject(players: newPlayers);
  }

  void invalidate() {
    ref.invalidateSelf();
  }

  void processUpdates(List<Update> updates) {
    List<Player> newState = state.players;
    for(Update u in updates) {
      if(u.type == 'newPlayer' && u.info is NewPlayerUpdateInfo) {
        var info = u.info as NewPlayerUpdateInfo;

        newState[u.player].setName(info.race);
      }
    }
    state = PlayerStateObject(players: newState);
  }
}

class PlayerStateObject {
  List<Player> players;
  PlayerStateObject({
    required this.players
  });
}