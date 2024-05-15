import 'package:client/model/request_response/coords.dart';
import 'package:client/model/request_response/update/update.dart';

class SystemPlacedUpdateInfo implements UpdateInfo {
  String system;
  Coords coords;

  SystemPlacedUpdateInfo({
    required this.system,
    required this.coords
  });

  factory SystemPlacedUpdateInfo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'system': String system,
        'location': Map<String, dynamic> json
      } =>
        SystemPlacedUpdateInfo(system: system, coords: Coords.fromJson(json)),
      _ => throw const FormatException('Failed to load SystemPlacedUpdateInfo.'),
    };
  }
}