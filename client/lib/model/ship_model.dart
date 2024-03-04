class ShipModel {
  ShipModel(this.cost, this.combat, this.movement, this.capacity, this.type);
  final int cost;
  final int combat;
  final int movement;
  final int capacity;
  final ShipType type;
}

enum ShipType {
  carrier,
  cruiser,
  destroyer,
  dreadnought,
  flagship,
  fighter,
  warsun,
}
