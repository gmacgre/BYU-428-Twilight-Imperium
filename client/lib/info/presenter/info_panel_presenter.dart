import 'package:client/info/presenter/info_presenter.dart';

class InfoPanelPresenter extends InfoPresenter {
  InfoPanelPresenter();

  bool isPlayer(int idx) {
    return (idx >= 0 && idx < getNumPlayers()); 
  }
}