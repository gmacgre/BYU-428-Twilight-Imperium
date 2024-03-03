class LoginResponse {
  final int playerTurn;
  final String userToken;

  LoginResponse({
    this.playerTurn = -1,
    this.userToken = "",
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'playerTurn': int playerTurn,
        'token': String userToken,
      } =>
        LoginResponse(
          playerTurn: playerTurn,
          userToken: userToken
        ),
      _ => throw const FormatException('Failed to load LoginResponse.'),
    };
  }

  Map<String, dynamic> toJson() => {
    'playerTurn': playerTurn,
    'token': userToken,
  };
}