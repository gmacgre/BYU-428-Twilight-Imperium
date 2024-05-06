class Player {
  String _race;
  int _tacticPool;
  int _fleetPool;
  int _strategyPool;
  int _victoryPoints;
  int _strategyCardId;
  bool _strategyExhausted;
  bool _passed;


  Player(
    this._race,
    this._strategyExhausted,
    this._tacticPool,
    this._fleetPool,
    this._strategyPool,
    this._victoryPoints,
    this._passed,
    this._strategyCardId
  );

  String getName() {
    return _race;
  }

  void setName(String newRace) {
    _race = newRace;
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

  factory Player.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'race': String race,
        'strategyExhausted': bool strategyExhausted,
        'tactic': int tactic,
        'fleet': int fleet,
        'strategyPool': int strategyPool,
        'victoryPoints': int victoryPoints,
        'passed': bool passed
      } =>
        Player(
          race,
          strategyExhausted,
          tactic,
          fleet,
          strategyPool,
          victoryPoints,
          passed,
          0
        ),
      _ => throw const FormatException('Failed to load Player.'),
    };
  }

  Map<String, dynamic> toJson() => {
    "race": _race,
    "strategyExhaused": _strategyExhausted,
    "tactic": _tacticPool,
    "fleet": _fleetPool,
    "strategyPool": _strategyPool,
    "victoryPoints": _victoryPoints,
    "passed": _passed,
    "strategyCardId": _strategyCardId
  };
}