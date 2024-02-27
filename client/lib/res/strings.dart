//This currently the best way to have content all in one place in flutter. There is a JSON reader version but I lost the aim in trying to make it work. This will do for now.
//Everything in this class should be both const and static, with no private variables.

class Strings {
  //Make class unable to be instantiated, only referenced statically
  Strings._();
  static const String tacticTokenDesc = 'Tactic tokens are used to activate systems in the Action Phase.\nThis allows for movement, combat, and production of units.';
  static const String fleetTokenDesc = 'Fleet tokens determine the max size of a player\'s fleet in any system.';
  static const String strategyTokenDesc = 'Strategy tokens are used to play the secondary ability of another\nplayer\'s strategy card when said player uses it.';
  static const String strategyCardDescription = 'Strategy cards determine initiative order, and can be played as an action.\nThe action played differs by strategy card.';
  static const List<String> strategyCardPowerDescription = [
    'Leadership:\nPrimary Ability:\n- Gain 3 Command Tokens.\n- Spend any amount of influence to gain 1 command token\n  for every 3 influence spent.\nSecondary Ability:\n- Spend any amount of influence to gain 1 command token\n  for every 3 influence spent.',
    'Diplomacy:\n- Choose 1 system other than the Mecatol Rex system\n  that contains a planet you control;\n  each other player places a command token\n  from their reinforcements in the chosen system.\n- Ready up to 2 exhausted planets you control.\nSecondary Ability:\n- Spend 1 token from your strategy pool\n  to ready up to 2 exhausted planets you control.',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  static const String invalidStrategyCard = 'This Strategy Card ID is invalid.';
}