import 'package:client/data/datacache.dart';
import 'package:client/data/strings.dart';
import 'package:client/board/info/global_info.dart';
import 'package:client/board/info/player_info.dart';
import 'package:client/model/riverpod/board_state.dart';
import 'package:client/model/player.dart';
import 'package:client/model/riverpod/player_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoPanel extends ConsumerWidget {
  const InfoPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Player> players = ref.watch(playerStateProvider).players;
    // Though unused, this ensures that child tabs can update when referencing this riverpod.
    // Do not remove.
    ref.watch(boardStateProvider).selectedCoordinate;  
    return DefaultTabController(
      length: players.length + 1,
      initialIndex: players.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.grey,
            bottom: TabBar(
              labelColor: Colors.black,
              //If we want a focus or splash color, change this line below here
              overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
              indicatorColor: Colors.black,
              tabs: _buildTabs(players)
            ),
          ),
        ),
        body: TabBarView(
          children: _buildChildren(players),
        ),
      )
    );
  }

  //A function that returns a list of IconButton Widgets.
  //This dynamically builds the number of tabs in the InfoPanel to have numPlayers + 1 Icons that can be selected as tabs.
  //When a tab is selected, selectIcon is called
  List<Widget> _buildTabs(List<Player> players) {
    List<Widget> toReturn = [];
    for(int i = 0; i < players.length + 1; i++) {
      toReturn.add(
        Tab(
          icon: Image(
            image: AssetImage(_getIcon(i, players)),
            height: 40,
            width: 40,
          )
        )
      );
    }
    return toReturn;
  }

  List<Widget> _buildChildren(List<Player> players) {
    List<Widget> toReturn = [];
    for(int i = 0; i < players.length + 1; i++) {
      toReturn.add(
        //Player widgets and Global Info Wigdets called and made here
        Center(
          child: DecoratedBox(
            decoration: const BoxDecoration(color: Colors.blueGrey),
            child: _isPlayer(i, players.length) ? 
              PlayerInfo(player: players[i], index: i) : 
              GlobalInfo(players: players, publicObjectives: DataCache.instance.publicObjectives)
          ),
        )
      );
    }
    return toReturn;
  }

  bool _isPlayer(int idx, int length) {
    if(idx < length && idx >= 0) return true;
    return false;
  }

  String _getIcon(int iconIdx, List<Player> players) {
    if(iconIdx == players.length) return Strings.agendaIcon;
    if(!_validIndex(iconIdx, players.length)) return Strings.codexIcon;
    if(players[iconIdx].getName() == Strings.noSelectedRace) return Strings.agendaIcon;
    return Strings.raceIcon(players[iconIdx].getName());
  }

  bool _validIndex(int idx, int length) {
    return !(idx < 0 || idx > length - 1);
  }
}
