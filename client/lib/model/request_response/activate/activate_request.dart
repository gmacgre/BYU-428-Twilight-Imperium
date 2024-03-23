class ActivateRequest {
  ActivateRequest(int x, int y) {
    coords = Location(x, y);
  }
  late final Location coords;

  Map<String, dynamic> toJson() => {
    'coords': coords.toJson()
  };
}

class Location {
  final int x;
  final int y;

  Location(this.x, this.y);

  Map<String, dynamic> toJson() => {
    'x': x,
    'y': y
  };
}
