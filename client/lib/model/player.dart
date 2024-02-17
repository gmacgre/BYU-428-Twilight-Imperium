class Player {
  final String _name;
  final int _tacticPool;
  final int _fleetPool;
  final int _strategyPool;
  final int _victoryPoints;
  final int _strategyCardId;

  Player(this._name, this._tacticPool, this._fleetPool, this._strategyPool, this._victoryPoints, this._strategyCardId);

  String getName() {
    return _name;
  }

  int getTacticPool() {
    return _tacticPool;
  }

  int getFleetPool() {
    return _fleetPool;
  }

  int getStrategyPool() {
    return _strategyPool;
  }

  int getVictoryPoints() {
    return _victoryPoints;
  }

  int getStrategyCard() {
    return _strategyCardId;
  }
}