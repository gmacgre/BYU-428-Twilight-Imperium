///This class is used to represent a coordinate in the hexagonal grid.
///It uses the indexes of the two-dimensional array instead of the axial coordinates.
class Coordinate {
  final int q;
  final int r;

  Coordinate(this.q, this.r);

  @override
  bool operator ==(Object other) {
    if (other is Coordinate) {
      return q == other.q && r == other.r;
    }
    return false;
  }

  @override
  int get hashCode => q.hashCode ^ r.hashCode;

  @override
  String toString() {
    return 'Coordinate{q: $q, r: $r}';
  }
}
