import 'package:client/board/planet.dart';
import 'package:client/board/system.dart';
import 'package:client/model/board_space_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BoardSpace extends StatefulWidget {
  const BoardSpace({super.key, required this.initialModel});
  final BoardSpaceModel initialModel;
  @override
  State<BoardSpace> createState() => _BoardSpaceState();
}

class _BoardSpaceState extends State<BoardSpace> {
  late BoardSpaceModel _model;
  updateState(BoardSpaceModel model) {
    setState(() {
      _model = model;
    });
  }

  @override
  initState() {
    super.initState();
    _model = widget.initialModel;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
