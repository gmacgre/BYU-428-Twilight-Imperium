import 'package:client/board/board_space.dart';
import 'package:client/board/presenter/board_grid_presenter.dart';
import 'package:client/model/board_grid_model.dart';
import 'package:flutter/widgets.dart';
import 'package:hexagon/hexagon.dart';

class BoardGrid extends StatefulWidget {
  ///The `BoardGrid` view renders 37 `BoardSpace` widgets in the hexagon shape.
  ///

  const BoardGrid({super.key});

  @override
  State<BoardGrid> createState() => _BoardGridState();
}

class _BoardGridState extends State<BoardGrid> implements BoardGridView {
  late BoardGridPresenter _presenter;
  late int _depth;

  late BoardGridModel _boardState;

  @override
  initState() {
    super.initState();
    _presenter = BoardGridPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return HexagonGrid.pointy(
      depth: _depth,
      padding: EdgeInsets.zero,
      width: 1000.0,
      height: 1000.0,
      buildTile: (coordinates) => HexagonWidgetBuilder(
        padding: 2.0,
        cornerRadius: 0,
        color: const Color.fromARGB(255, 0, 144, 99),
        child: const Text('test'),
      ),
      buildChild: (coordinates) {
        //Adding the _depth is necessary to force everything to be a positive value.
        //The hex grid makes the origin (0,0) the middle of the grid, but since 
        //lists can't have negative indexes we need to adjust accordingly.  
        return BoardSpace(initialModel: _boardState.spaces[(coordinates.q + _depth)][(coordinates.r + _depth)]);
      },
    );
  }

  @override
  void onBind(int depth) {
    _depth = depth;
  }

  @override
  void setBoardState(BoardGridModel model) {
    setState(() {
      _boardState = model;
    });
  }
}