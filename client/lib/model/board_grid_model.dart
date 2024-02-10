import 'package:client/model/board_space_model.dart';

class BoardGridModel {

//Check out this stupid math to get a hex grid working where 0,0 is the middle
  BoardGridModel(this._depth) {
    _spaces = List<List<BoardSpaceModel>>.generate(
      (_depth * 2) + 1,
      (q) => List<BoardSpaceModel>.generate(
        (_depth * 2) + 1,
        (r) => BoardSpaceModel(q, r , '$q, $r'),
        growable: false,
      ),
      growable: false,
    );
  }
  late List<List<BoardSpaceModel>> _spaces;
  final int _depth;

  set spaces(spaces) => _spaces = spaces;
  List<List<BoardSpaceModel>> get spaces => _spaces;
  setSpace(int q, int r, BoardSpaceModel space) => _spaces[q][r] = space;
}
