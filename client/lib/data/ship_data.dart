import 'package:client/model/ship_model.dart';

class ShipData {
  static final Map<ShipType, ShipModel> defaultData = {
    ShipType.warsun: ShipModel(1, 9, 0, 0, ShipType.warsun),
    ShipType.dreadnought: ShipModel(4, 5, 1, 1, ShipType.dreadnought),
    ShipType.cruiser: ShipModel(2, 7, 2, 0, ShipType.cruiser),
    ShipType.carrier: ShipModel(3, 9, 1, 4, ShipType.carrier),
    ShipType.destroyer: ShipModel(1, 9, 2, 0, ShipType.destroyer),
    ShipType.fighter: ShipModel(1, 9, 0, 0, ShipType.fighter),
  };
}