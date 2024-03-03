// ignore_for_file: unused_field

import 'package:client/data/system_data.dart';
import 'package:client/model/system_state.dart';

class BoardSpaceModel {
  BoardSpaceModel(
    this._q,
    this._r,
    this.system,
  );
//Axial coordinates
  final int _q;
  final int _r;

  final SystemModel system;
  SystemState? state;
}
