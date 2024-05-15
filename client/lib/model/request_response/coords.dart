class Coords {
  final int x;
  final int y;

  Coords({
    required this.x,
    required this.y
  });

  factory Coords.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'x': int x,
        'y': int y
      } =>
        Coords(x: x, y: y),
      _ => throw const FormatException('Failed to load Coords.')
    };
  }
}