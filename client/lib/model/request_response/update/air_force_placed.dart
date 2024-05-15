import 'package:client/model/request_response/coords.dart';
import 'package:client/model/request_response/update/update.dart';
import 'package:client/model/ship_model.dart';

class AirForcePlacedUpdateInfo implements UpdateInfo {

  List<ShipType> airforce;
  Coords coords;
  AirForcePlacedUpdateInfo({
    required this.airforce,
    required this.coords
  });

  factory AirForcePlacedUpdateInfo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'airforce': List<dynamic> forces,
        'location': Map<String, dynamic> json
      } =>
        AirForcePlacedUpdateInfo(airforce: List<ShipType>.from(forces.map((e) => ShipTypeFactory.fromJson(e))), coords: Coords.fromJson(json)),
      _ => throw const FormatException('Failed to load AirForcePlacedUpdateInfo.'),
    };
  }
}