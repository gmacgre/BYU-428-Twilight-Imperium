import 'package:client/info/presenter/info_presenter.dart';

class GlobalInfoPresenter extends InfoPresenter {
  GlobalInfoPresenter();
  
  List<int> getUntakenStrategyCards() {
    int players = getNumPlayers();
    Set<int> toReturn = {1, 2, 3, 4, 5, 6, 7, 8};
    for(int i = 0; i < players; i++) {
      toReturn.remove(getStrategyCard(i));
    }
    return toReturn.toList();
  }
}