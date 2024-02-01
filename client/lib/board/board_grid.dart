import 'package:client/board/board_space.dart';
import 'package:flutter/widgets.dart';
import 'package:hexagon/hexagon.dart';

class BoardGrid extends StatelessWidget {
  const BoardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return HexagonGrid.pointy(
      depth: 3,
      padding: EdgeInsets.zero,
      width: 1000.0,
      height: 1000.0,
      buildTile: (coordinates) => HexagonWidgetBuilder(
        padding: 2.0,
        cornerRadius: 0,
        color: Color.fromARGB(255, 0, 144, 99),
        child: Text('test'),
      ),
    );
  }
}
