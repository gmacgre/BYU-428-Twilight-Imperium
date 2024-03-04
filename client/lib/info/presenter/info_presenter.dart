import 'package:client/data/datacache.dart';
import 'package:client/model/objective.dart';
abstract class InfoPresenter {
  
  final DataCache _cache = DataCache.instance;

  int getNumPlayers() {
    return _cache.players.length;
  }

  String getIcon(int iconIdx) {
    if(iconIdx == getNumPlayers()) return 'icons/color/general/agenda.png';
    if(!_validIndex(iconIdx)) return 'icons/color/general/codex.png';
    return 'icons/color/race/${_cache.players[iconIdx].getName()}.png';
  }

  int getStrategyCard(int idx) {
    if(_validIndex(idx)) return _cache.players[idx].getStrategyCard();
    return -1;
  }

  int getTacticPool(int idx) {
    if(_validIndex(idx)) return _cache.players[idx].getTacticPool();
    return -1;
  }

  int getFleetPool(int idx) {
    if(_validIndex(idx)) return _cache.players[idx].getFleetPool();
    return -1;
  }

  int getStrategyPool(int idx) {
    if(_validIndex(idx)) return _cache.players[idx].getStrategyPool();
    return -1;
  }

  int getVictoryPoints(int idx) {
    if(_validIndex(idx)) return _cache.players[idx].getVictoryPoints();
    return -1;
  }

  bool _validIndex(int idx) {
    return !(idx < 0 || idx > getNumPlayers() - 1);
  }

  List<Objective> getPublicObjectives() {
    return _cache.publicObjectives;
  }
}