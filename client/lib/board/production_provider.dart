import 'package:client/model/board_state.dart';
import 'package:client/model/ship_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'production_provider.g.dart';

@riverpod
class Production extends _$Production {
  @override
  ProductionObject build() {
    return ProductionObject(selectedQuantities: {
      ShipType.carrier: 0,
      ShipType.cruiser: 0,
      ShipType.destroyer: 0,
      ShipType.dreadnought: 0,
      ShipType.flagship: 0,
      ShipType.fighter: 0,
      ShipType.warsun: 0,
    });
  }

  void updateSelectedQuantity(ShipType type, int quantity) {
    state = ProductionObject(
        selectedQuantities: {...state.selectedQuantities, type: quantity});
  }

  void submit() {
    ref.read(boardStateProvider.notifier).addShips(state.selectedQuantities);
  }

  void cancel() {
    ref.invalidateSelf();
  }
}

class ProductionObject {
  final Map<ShipType, int> selectedQuantities;
  ProductionObject({required this.selectedQuantities});
}
