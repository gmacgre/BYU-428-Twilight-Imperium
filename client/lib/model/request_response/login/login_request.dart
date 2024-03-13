class LoginRequest {
  final String roomCode;
  final String roomPassword;
  final int playerTurn;
  LoginRequest({
    required this.roomCode,
    required this.roomPassword,
    required this.playerTurn
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'roomCode': String roomCode,
        'roomPass': String roomPassword,
        'playerTurn': int playerTurn
      } =>
        LoginRequest(
          roomCode: roomCode,
          roomPassword: roomPassword,
          playerTurn: playerTurn
        ),
      _ => throw const FormatException('Failed to load LoginRequest.'),
    };
  }

  Map<String, dynamic> toJson() => {
    'roomCode': roomCode,
    'roomPass': roomPassword,
    'playerNum': playerTurn
  };
}