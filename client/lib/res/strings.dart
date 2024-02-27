//This currently the best way to have content all in one place in flutter. There is a JSON reader version but I lost the aim in trying to make it work. This will do for now.
//Everything in this class should be both const and static, with no private variables.

class Strings {
  //Make class unable to be instantiated, only referenced statically
  Strings._();
  static const String appTitle = 'TWILIGHT IMPERIUM';
  static const String tagLine = 'Pax Magnifica, Bellum Gloriosum';
  static const String joinGame = 'Join Game';
  static const String createGame = 'Create Game';
  static const String codeInput = 'Input Room Name';
  static const String passwordInput = 'Input Room Password';
  static const String needBothRoomInput = 'Enter both the Room Code and Password.';
  static const String loginAttempt = 'Attempting to Log In...';
  static const String createAttempt = 'Attempting to Create Game...';
  static const String fleet = 'Fleet';
  static const String tactic = 'Tactic';
  static const String strategy = 'Strategy';
  static const String tacticTokenDesc = 'Tactic tokens are used to activate systems in the Action Phase.\nThis allows for movement, combat, and production of units.';
  static const String fleetTokenDesc = 'Fleet tokens determine the max size of a player\'s fleet in any system.';
  static const String strategyTokenDesc = 'Strategy tokens are used to play the secondary ability of another\nplayer\'s strategy card when said player uses it.';
  static const String strategyCardDescription = 'Strategy cards determine initiative order, and can be played as an action.\nThe action played differs by strategy card.';
  static const List<String> strategyCardPowerDescription = [
    'Leadership:\nPrimary Ability:\n- Gain 3 Command Tokens.\n- Spend any amount of influence to gain 1 command token\n  for every 3 influence spent.\nSecondary Ability:\n- Spend any amount of influence to gain 1 command token\n  for every 3 influence spent.',
    'Diplomacy:\nPrimary Ability:\n- Choose 1 system other than the Mecatol Rex system\n  that contains a planet you control;\n  each other player places a command token\n  from their reinforcements in the chosen system.\n- Ready up to 2 exhausted planets you control.\nSecondary Ability:\n- Spend 1 token from your strategy pool\n  to ready up to 2 exhausted planets you control.',
    'Politics:\nPrimary Ability:\n- Choose a player other than the speaker;\n  That player gains the speaker token.\n- Draw 2 action cards.\n- Look at the top 2 cards of the agenda deck;\n  Place each card on the top or bottom of the deck in any order.\nSecondary Ability:\n- Spend 1 token from your strategy pool to draw 2 action cards.',
    'Construction:\nPrimary Ability:\n- Place 1 PDS or 1 Space Dock on a planet you control.\n- Place 1 PDS on a planet you control.\nSecondary Ability:\n- Spend 1 token from your strategy pool and place it in any system;\n  you may place either 1 space dock or 1 PDS\n  on a planet you control in that system.',
    'Trade:\nPrimary Ability:\n- Gain 3 trade goods.\n- Replenish commodities.\n- Choose any number of other players. Those players use the secondary ability\n  of this strategy card without spending a command token.\nSecondary Ability:\n- Spend 1 token from your strategy pool to replenish your commodities.',
    'Warfare:\nPrimary Ability:\n- Remove 1 of your command tokens from the game board.\n- Gain 1 command token.\n- Redistribute any number of the command tokens on your command sheet.\nSecondary Ability:\n- Spend 1 token from your strategy pool to use the Production ability\n  of 1 of your space docks in your home system.\n  (This token is not placed in your home system.)',
    'Technology:\nPrimary Ability:\n- Research 1 technology.\n- Spend 6 resources to research 1 technology.\nSecondary Ability:\n- Spend 1 token from your strategy pool and 4 resources to research 1 technology.',
    'Imperial:\nPrimary Ability:\n- Immediately score 1 public objective if you fulfill its requirements.\n- Gain 1 victory point if you control Mecatol Rex;\n  otherwise, draw 1 secret objective.\nSecondary Ability:\n-  Spend 1 token from your strategy pool to draw 1 secret objective.',
  ];
  static const String invalidStrategyCard = 'This Strategy Card ID is invalid.';
  static String tokenCount(int count, String type) {
    return 'This player has $count ${type.toLowerCase()} token(s).';
  }
  static String successNeedConnect(String code, String id) {
    return "Success! Connecting to $code ($id)...";
  }
}