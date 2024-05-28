import 'package:client/data/datacache.dart';
import 'package:client/model/riverpod/board_state.dart';
import 'package:client/model/riverpod/player_state.dart';
import 'package:client/model/request_response/update/update.dart';
import 'package:client/pages/game/board/board_grid.dart';
import 'package:client/pages/game/command/command.dart';
import 'package:client/pages/game/info/info_panel.dart';
import 'package:client/updater/update_thread.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key});

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> implements UpdateThreadObserver {
  bool _deSynced = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    
    Widget toReturn = Row(
      children: [
        const Expanded(
          flex: 3,
          child: InfoPanel(),
        ),
        Expanded(
          flex: 7,
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 12, 12, 40),
            ),
            child: const Column(
              children: [
                Expanded(
                  flex: 17,
                  child: BoardGrid(),
                ),
                Expanded(
                  flex: 3,
                  child: CommandWidget()
                )
              ],
            ),
          ),
        ),
      ],
    );
    String token = DataCache.instance.userToken;
    // if(token == "") {
    //   Future.microtask(() 
    //   {
    //     Navigator.of(context).pushNamed('/');
    //     UpdateThread.thread.stop();
    //   }
    //   );
    // }
    //Start a thread that repeatedly gets updates or the game state
    UpdateThread updater = UpdateThread.thread;
    updater.start(this, token);

    return (_deSynced) ? Stack(
      children: [
        toReturn,
        DecoratedBox(
          decoration: const BoxDecoration(color: Colors.black38),
          child: SizedBox(
            width: width,
            height: height,
            child: const Center(
              child: Text(
                'DESYNCED GAME',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ),
        ),
      ],
    ) : toReturn;
  }
  
  @override
  void presentUpdate(List<Update> updates) {
    ref.read(playerStateProvider.notifier).processUpdates(updates);
    ref.read(boardStateProvider.notifier).processUpdates(updates);
  }
  
  @override
  void showDesync(bool val) {
    setState(() {
      _deSynced = val;
    });
  }
}
