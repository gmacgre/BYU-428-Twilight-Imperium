import 'package:client/model/ship_model.dart';

class MoveRequest {
  late List<_ShipOrder> _ships;

  MoveRequest(List<ShipModel> ships, List<List<int>> coords) {
    List<_ShipOrder> orders = [];
    for(int i = 0; i < ships.length; i++) {
      _ShipOrder order = _ShipOrder(_shipTypeToString(ships[i].type), coords[i][0], coords[i][1]);
      orders.add(order);
    }
    _ships = orders;
  }

  String _shipTypeToString(ShipType type) {
    Map<ShipType, String> converter = {
      ShipType.carrier: 'carrier',
      ShipType.cruiser: 'cruiser',
      ShipType.destroyer: 'destroyer',
      ShipType.dreadnought: 'dreadnought',
      ShipType.fighter: 'fighter',
      ShipType.flagship: 'flagship',
      ShipType.warsun: 'warsun'
    };
    return converter[type]!;
  }

  Map<String, dynamic> toJson() => {
    'ships': _ships.map((order) => order.toJson()).toList()
  };
}

class _ShipOrder {
  late final _Location location;
  final String shipClass;
  _ShipOrder(this.shipClass, int x, int y) {
    location = _Location(x, y);
  }
  Map<String, dynamic> toJson() => {
    'shipClass': shipClass,
    'coords': location.toJson()
  };
}

class _Location {
  int x;
  int y;
  _Location(this.x, this.y);

  Map<String, dynamic> toJson() => {
    'x': x,
    'y': y
  };
}