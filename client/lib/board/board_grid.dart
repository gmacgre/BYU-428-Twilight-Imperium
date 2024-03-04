import 'package:client/board/board_space.dart';
import 'package:client/board/presenter/board_grid_presenter.dart';
import 'package:client/model/board_grid_model.dart';
import 'package:client/model/board_state.dart';
import 'package:client/model/system_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexagon/hexagon.dart';

class BoardGrid extends ConsumerStatefulWidget {
  const BoardGrid({super.key});

  final int _depth = 3;

  @override
  ConsumerState<BoardGrid> createState() => _BoardGridState();
}

class _BoardGridState extends ConsumerState<BoardGrid> {
@override
  Widget build(BuildContext context) {
    BoardGridPresenter presenter = BoardGridPresenter(_BoardGridView());
    presenter.startLoop();
    List<List<SystemState>> state = ref.watch(boardStateProvider);
    return HexagonGrid.flat(
      depth: widget._depth,
      padding: EdgeInsets.zero,
      buildTile: (coordinates) => HexagonWidgetBuilder(
        padding: 2.0,
        cornerRadius: 0,
        color: const Color.fromARGB(255, 0, 0, 100),
      ),
      buildChild: (coordinates) {
        //Adding the _depth is necessary to force everything to be a positive value.
        //The hex grid makes the origin (0,0) the middle of the grid, but since
        //lists can't have negative indexes we need to adjust accordingly.
        //To translate from model to view, subtract _depth to coordinates
        //To transalte from view to model, add _depth from coordinates
        return BoardSpace(
          col: coordinates.q + widget._depth,
          row: coordinates.r + widget._depth,
          systemState: state[(coordinates.q + widget._depth)][(coordinates.r + widget._depth)],
        );

        //Text("${coordinates.q} ${coordinates.r}");
      },
    );
  }
}

class _BoardGridView implements BoardGridView {
  @override
  void onBind(int depth) {
    // TODO: implement onBind
  }
  @override
  void setBoardState(BoardGridModel model) {
    // TODO: implement setBoardState
  }
}
