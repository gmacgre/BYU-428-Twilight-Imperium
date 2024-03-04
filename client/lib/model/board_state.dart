import 'package:client/data/datacache.dart';
import 'package:client/model/ship_model.dart';
import 'package:client/model/system_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'board_state.g.dart';

@riverpod
class BoardState extends _$BoardState {
  int? _col;
  int? _row;

  @override
  List<List<SystemState>> build() {
    //This will need to get the initial cached state from the DataCache
    return DataCache.instance.boardState;
  }

  void updateSystem(SystemState newState, int col, int row) {
    var oldState = [...state];
    oldState[col][row] = newState;
    print('updatingSystem');
    state = oldState;
    //Any call to the server can be made here to send the request
  }

  void addShip(ShipModel ship, int col, int row) {
    var system = state[col][row];
    system.airSpace.add(ship);
    updateSystem(system, col, row);
  }

  void removeShip(ShipModel ship, int col, int row) {
    var system = state[col][row];
    system.airSpace.remove(ship);
    updateSystem(system, col, row);
  }

  void activateSystem(int col, int row) {
    if(_col != null && _row != null){
      deactivateSystem(_col!, _row!);
    }
    _col = col;
    _row = row;
    var system = state[col][row];
    system.activated = true;
    print('activated $col, $row');
    updateSystem(system, col, row);
  }

  void deactivateSystem(int col, int row) {
    _col = null;
    _row = null;
    var system = state[col][row];
    system.activated = false;
    updateSystem(system, col, row);
  }

  int? getActiveCol(){
    return _col;
  }
  int? getActiveRow(){
    return _row;
  }

}
