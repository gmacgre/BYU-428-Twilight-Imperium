class CreateResponse {
  final int playerTurn;
  final String userToken;

  CreateResponse({
    required this.playerTurn,
    required this.userToken
  });

  factory CreateResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'playerTurn': int turn,
        'token': String userToken,
      } =>
        CreateResponse(
          playerTurn: turn,
          userToken: userToken
        ),
      _ => throw const FormatException('Failed to load CreateResponse.'),
    };
  }

  Map<String, dynamic> toJson() => {
    'playerTurn': playerTurn,
    'token': userToken
  };
}