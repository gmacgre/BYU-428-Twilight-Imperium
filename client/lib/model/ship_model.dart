import 'dart:math';

class ShipModel {
  ShipModel(this.cost, this.combat, this.movement, this.capacity, this.type) {
    //Generate a random unique id for the ship
    id = (DateTime.now().millisecondsSinceEpoch / Random().nextInt(1000))
        .toString();
  }
  late String id;
  final int cost;
  final int combat;
  final int movement;
  final int capacity;
  final ShipType type;

  @override
  operator ==(Object other) {
    if (other is ShipModel) {
      return equals(other);
    }
    return false;
  }

  equals(ShipModel other) {
    return id == other.id &&
        cost == other.cost &&
        combat == other.combat &&
        movement == other.movement &&
        capacity == other.capacity &&
        type == other.type;
  }

  @override
  int get hashCode =>
      cost.hashCode ^
      combat.hashCode ^
      movement.hashCode ^
      capacity.hashCode ^
      type.hashCode;
}

enum ShipType {
  carrier(label: "Carrier"),
  cruiser(label: "Cruiser"),
  destroyer(label: "Destroyer"),
  dreadnought(label: "Dreadnought"),
  flagship(label: "Flagship"),
  fighter(label: "Fighter"),
  warsun(label: "War Sun");

  final String label;
  const ShipType({required this.label});
}
