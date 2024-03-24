import 'package:client/board/board_grid.dart';
import 'package:client/info/info_panel.dart';
import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SizedBox(
          width: width * 0.3,
          child: const InfoPanel(),
        ),
        const Expanded(
          child: BoardGrid(),
        ),
      ],
    );
  }
}
