enum TurnPhase {
  observation,
  activation,
  movement,
  combat,
  invasion,
  production,
  error
}

class TurnPhaseFactory {
  static TurnPhase fromString(String input) {
    switch(input) {
      case 'OBSERVE':
        return TurnPhase.observation;
      case 'MOVE':
        return TurnPhase.movement;
      case 'ACTION':
        return TurnPhase.activation;        
    }
    return TurnPhase.error;
  }
}