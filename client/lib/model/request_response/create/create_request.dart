class CreateRequest {
  final String roomCode;
  final String roomPassword;
  CreateRequest({
    required this.roomCode,
    required this.roomPassword
  });

  factory CreateRequest.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'roomCode': String roomCode,
        'roomPassword': String roomPassword
      } =>
        CreateRequest(
          roomCode: roomCode, 
          roomPassword: roomPassword
        ),
      _ => throw const FormatException('Failed to load CreateRequest'),
    };
  }


  Map<String, dynamic> toJson() => {
    'roomCode': roomCode,
    'roomPassword': roomPassword,
  };
}