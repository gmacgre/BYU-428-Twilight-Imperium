class CreateResponse {
  final String roomCode;
  final String roomPassword;
  final String gameId;
  final String userToken;

  CreateResponse({
    required this.roomCode,
    required this.roomPassword,
    required this.gameId,
    required this.userToken
  });

  factory CreateResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'roomCode': String roomCode,
        'roomPassword': String roomPassword,
        'gameId': String gameId,
        'userToken': String userToken,
      } =>
        CreateResponse(
          roomCode: roomCode,
          roomPassword: roomPassword,
          gameId: gameId,
          userToken: userToken
        ),
      _ => throw const FormatException('Failed to load LoginResponse.'),
    };
  }

  Map<String, dynamic> toJson() => {
    'roomCode': roomCode,
    'roomPassword': roomPassword,
    'gameId': gameId,
    'userToken': userToken
  };
}