import 'package:client/model/game_state.dart';
import 'package:client/model/objective.dart';

abstract class InfoPresenter {
  //TODO: WILL EVENTUALLY BE REPLACED WITH GETTING THIS FROM THE MODEL
  final GameState _model = GameState();
 
  int getNumPlayers() {
    return _model.getNumPlayers();
  }

  String getIcon(int iconIdx) {
    if(iconIdx == getNumPlayers()) return 'icons/color/general/agenda.png';
    if(!_validIndex(iconIdx)) return 'icons/color/race/yssaril.png';
    return 'icons/color/race/${_model.getPlayer(iconIdx).getName()}.png';
  }

  int getStrategyCard(int idx) {
    if(_validIndex(idx)) return _model.getPlayer(idx).getStrategyCard();
    return -1;
  }

  int getTacticPool(int idx) {
    if(_validIndex(idx)) return _model.getPlayer(idx).getTacticPool();
    return -1;
  }

  int getFleetPool(int idx) {
    if(_validIndex(idx)) return _model.getPlayer(idx).getFleetPool();
    return -1;
  }

  int getStrategyPool(int idx) {
    if(_validIndex(idx)) return _model.getPlayer(idx).getStrategyPool();
    return -1;
  }

  int getVictoryPoints(int idx) {
    if(_validIndex(idx)) return _model.getVictoryPoints(idx);
    return -1;
  }

  bool _validIndex(int idx) {
    return !(idx < 0 || idx > getNumPlayers() - 1);
  }

  List<Objective> getPublicObjectives() {
    return _model.getPublicObjectives();
  }
}