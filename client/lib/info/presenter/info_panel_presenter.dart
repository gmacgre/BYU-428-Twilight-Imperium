class InfoPanelPresenter {
  InfoPanelPresenter(this.players);

  //TODO: WILL EVENTUALLY BE REPLACED
  final List<String> _playerFactions = [
    'jol_nar',
    'sol',
    'hacan',
    'sardakk',
    'xxcha',
    'mahact'
  ];
  int players;
  
  int getNumPlayers() {
    return players;
  }

  String getIcon(int iconIdx) {
    if(iconIdx == 0) {
      return 'icons/color/general/agenda.png';
    }
    if(iconIdx < 0 || iconIdx > players) return 'icons/color/race/yin.png';
    return 'icons/color/race/${_playerFactions[iconIdx - 1]}.png';
  }
}

abstract interface class InfoPanelView {
  void reload();
}