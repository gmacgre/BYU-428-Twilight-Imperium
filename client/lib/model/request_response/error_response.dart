class ErrorResponse {
  final String message;
  ErrorResponse({this.message = ""});
  Map<String, dynamic> toJson() => {
    'message': message,
  };
  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'message': String message
      } =>
        ErrorResponse(
          message: message
        ),
      _ => throw const FormatException('Failed to load ErrorResponse.'),
    };
  }
}