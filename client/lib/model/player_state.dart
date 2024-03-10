import 'package:client/data/datacache.dart';
import 'package:client/model/player.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_state.g.dart';

@riverpod
class PlayerState extends _$PlayerState {

  @override
  List<Player> build() {
    return DataCache.instance.players;
  }

}