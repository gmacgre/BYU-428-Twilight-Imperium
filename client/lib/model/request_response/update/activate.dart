import 'package:client/model/request_response/coords.dart';
import 'package:client/model/request_response/update/update.dart';

class ActivateUpdateInfo implements UpdateInfo {

  ActivateUpdateInfo({
    required this.coords
  });

  Coords coords;


  factory ActivateUpdateInfo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'location': Map<String, dynamic> json
      } =>
        ActivateUpdateInfo(coords: Coords.fromJson(json)),
      _ => throw const FormatException('Failed to load ActivateUpdateInfo.'),
    };
  }
}