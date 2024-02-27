import 'package:client/data/system_data.dart';
import 'package:client/model/board_space_model.dart';

class BoardGridModel {
  BoardGridModel(this._depth) {
    // _spaces = List<List<BoardSpaceModel>>.generate(
    //   (_depth * 2) + 1,
    //   (q) => List<BoardSpaceModel>.generate(
    //     (_depth * 2) + 1,
    //     (r) => BoardSpaceModel(
    //       q,
    //       r,
    //       '$q, $r',
    //       SystemData.systemList[]!,
    //     ),
    //     growable: false,
    //   ),
    //   growable: false,
    // );
    _spaces = List<List<BoardSpaceModel>>.empty(growable: true);
    for (int i = 0; i < (_depth * 2) + 1; i++) {
      var row = List<BoardSpaceModel>.empty(growable: true);
      for (int j = 0; j < (_depth * 2) + 1; j++) {
        row.add(BoardSpaceModel(i, j, board[i][j]));
      }
      _spaces.add(row);
    }
  }
  late List<List<BoardSpaceModel>> _spaces;
  final int _depth;

  set spaces(spaces) => _spaces = spaces;
  List<List<BoardSpaceModel>> get spaces => _spaces;
  setSpace(int q, int r, BoardSpaceModel space) => _spaces[q][r] = space;

  static List<List<SystemModel>> board = [
    [
      SystemData.systemList['Empty']!,
      SystemData.systemList['Empty']!,
      SystemData.systemList['Empty']!,
      SystemData.systemList['Hercant']!,
      SystemData.systemList['Abyz']!,
      SystemData.systemList['Arinam']!,
      SystemData.systemList['Arnor']!,
      SystemData.systemList['Bereg']!,
    ],
    [
      SystemData.systemList['Empty']!,
      SystemData.systemList['Empty']!,
      SystemData.systemList['Centauri']!,
      SystemData.systemList['Coorneeq']!,
      SystemData.systemList['Dal Bootha']!,
      SystemData.systemList['Lazar']!,
      SystemData.systemList['Lodor']!,
    ],
    [
      SystemData.systemList['Empty']!,
      SystemData.systemList['Mehar Xull']!,
      SystemData.systemList['Empty']!,
      SystemData.systemList['Mellon']!,
      SystemData.systemList['Empty']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
    ],
    [
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
    ],
    [
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
    ],
    [
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
    ],
    [
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
      SystemData.systemList['Mecatol Rex']!,
    ],
  ];
}