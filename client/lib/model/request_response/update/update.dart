import 'package:client/model/request_response/update/activate.dart';
import 'package:client/model/request_response/update/air_force_placed.dart';
import 'package:client/model/request_response/update/ground_force_placed.dart';
import 'package:client/model/request_response/update/new_player.dart';
import 'package:client/model/request_response/update/spacedock_placed.dart';
import 'package:client/model/request_response/update/system_placed.dart';
import 'package:client/model/request_response/update/unknown.dart';

class Update {
  String type;
  int player;
  UpdateInfo info;

  Update({
    required this.type,
    required this.player,
    required this.info
  });


  factory Update.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'type': String type,
        'player': int player,
        'info': Map<String, dynamic> info
      } =>
        Update(
          type: type,
          player: player,
          info: _getUpdateInfo(info, type)
        ),
      _ => throw const FormatException('Failed to load LoginResponse.'),
    };
  }

  static UpdateInfo _getUpdateInfo(Map<String, dynamic> info, String type) {
    return switch (type) {
      'newPlayer' => NewPlayerUpdateInfo.fromJson(info),
      'activate' => ActivateUpdateInfo.fromJson(info),
      'groundForcePlaced' => GroundForcePlacedUpdateInfo.fromJson(info),
      'airforcePlaced' => AirForcePlacedUpdateInfo.fromJson(info),
      'systemPlaced' => SystemPlacedUpdateInfo.fromJson(info),
      'spacedockPlaced' => SpacedockPlacedUpdateInfo.fromJson(info),
      _ => UnknownUpdateInfo()
    };
  }

}

// Holder Generic class that all updates inherit, do not add to
abstract class UpdateInfo {}