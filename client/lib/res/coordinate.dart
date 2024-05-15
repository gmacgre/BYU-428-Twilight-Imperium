///This class is used to represent a coordinate in the hexagonal grid.
///It uses the indexes of the two-dimensional array instead of the axial coordinates.
class Coords {
  final int x;
  final int y;

  Coords(this.x, this.y);

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is Coords &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() {
    return 'Coordinate{x: $x, y: $y}';
  }


  factory Coords.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'x': int x,
        'y': int y
      } =>
        Coords(x, y),
      _ => throw const FormatException('Failed to load Coords.')
    };
  }
}
