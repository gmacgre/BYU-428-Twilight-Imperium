import 'package:client/model/request_response/update/update.dart';
import 'package:client/res/coordinate.dart';

class GroundForcePlacedUpdateInfo implements UpdateInfo {
  int planetIdx;
  int quantity;
  Coords coords;
  GroundForcePlacedUpdateInfo({
    required this.planetIdx,
    required this.quantity,
    required this.coords
  });
  factory GroundForcePlacedUpdateInfo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'planet': int planet,
        'numForces': int numForces,
        'location': Map<String, dynamic> json
      } =>
        GroundForcePlacedUpdateInfo(planetIdx: planet, quantity: numForces, coords: Coords.fromJson(json)),
      _ => throw const FormatException('Failed to load GroundForcePlacedUpdateInfo.'),
    };
  }
}