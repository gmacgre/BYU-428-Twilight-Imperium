import 'package:client/model/update/activate.dart';
import 'package:client/model/update/new_player.dart';
import 'package:client/model/update/unknown.dart';

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
    switch(type) {
      case 'newPlayer': {
        return NewPlayerUpdateInfo.fromJson(info);
      }

      case 'activate': {
        return ActivateUpdateInfo.fromJson(info);
      }

      case _: {
        return UnknownUpdateInfo();
      }
    }
  }

}

// Holder Generic class that all updates inherit, do not add to
abstract class UpdateInfo {}