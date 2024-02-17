import 'package:client/info/global_info.dart';
import 'package:client/info/player_info.dart';
import 'package:flutter/material.dart';
import "package:client/info/presenter/info_panel_presenter.dart";

class InfoPanel extends StatefulWidget {
  const InfoPanel({super.key});

  @override
  State<InfoPanel> createState() => _InfoPanelState();
}

class _InfoPanelState extends State<InfoPanel> {

  late InfoPanelPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = InfoPanelPresenter();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _presenter.getNumPlayers() + 1,
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
              tabs: _buildTabs()
            ),
          ),
        ),
        body: TabBarView(
          children: _buildChildren(),
        ),
      )
    );
  }

  //A function that returns a list of IconButton Widgets.
  //This dynamically builds the number of tabs in the InfoPanel to have numPlayers + 1 Icons that can be selected as tabs.
  //When a tab is selected, selectIcon is called
  List<Widget> _buildTabs() {
    List<Widget> toReturn = [];
    for(int i = 0; i < _presenter.getNumPlayers() + 1; i++) {
      toReturn.add(
        Tab(
          icon: Image(
            image: AssetImage(_presenter.getIcon(i)),
            height: 40,
            width: 40,
          )
        )
      );
    }
    return toReturn;
  }

  List<Widget> _buildChildren() {
    List<Widget> toReturn = [];
    for(int i = 0; i < _presenter.getNumPlayers() + 1; i++) {
      toReturn.add(
        //Player widgets and Global Info Wigdets called and made here
        Center(
          child: _presenter.isPlayer(i) ? PlayerInfo(playerIndex: i) : const GlobalInfo()
        )
      );
    }
    return toReturn;
  }

}