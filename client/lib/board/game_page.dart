import 'package:client/board/board_grid.dart';
import 'package:client/info/info_panel.dart';
import 'package:client/updater/update_thread.dart';
import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget toReturn = Row(
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

    //Start a thread that repeatedly gets updates or the game state
    UpdateThread updater = UpdateThread();
    updater.start();

    return toReturn;
  }
}
