import 'package:client/model/request_response/update/update.dart';
import 'package:client/res/coordinate.dart';

class SpacedockPlacedUpdateInfo implements UpdateInfo {
  int planetIdx;
  Coords coords;
  SpacedockPlacedUpdateInfo({
    required this.planetIdx,
    required this.coords
  });
  factory SpacedockPlacedUpdateInfo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'spacedockIndex': int planet,
        'location': Map<String, dynamic> json
      } =>
        SpacedockPlacedUpdateInfo(planetIdx: planet, coords: Coords.fromJson(json)),
      _ => throw const FormatException('Failed to load SpacedockPlacedUpdateInfo.'),
    };
  }
}