class LoginRequest {
  final String roomCode;
  final String roomPassword;
  LoginRequest({
    required this.roomCode,
    required this.roomPassword
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'roomCode': String roomCode,
        'roomPassword': String roomPassword,
      } =>
        LoginRequest(
          roomCode: roomCode,
          roomPassword: roomPassword,
        ),
      _ => throw const FormatException('Failed to load LoginRequest.'),
    };
  }

  Map<String, dynamic> toJson() => {
    'roomCode': roomCode,
    'roomPassword': roomPassword,
  };
}