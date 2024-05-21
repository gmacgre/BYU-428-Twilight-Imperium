import 'package:client/model/request_response/update/update.dart';
import 'package:client/res/coordinate.dart';

class PDSPlacedUpdateInfo implements UpdateInfo {
  int planetIdx;
  Coords coords;
  PDSPlacedUpdateInfo({
    required this.planetIdx,
    required this.coords
  });

  factory PDSPlacedUpdateInfo.fromJson(Map<String, dynamic> json) {
    return switch(json) {
      {
        'pdsIdx': int planetIdx,
        'location': Map<String, dynamic> json
      } =>
      PDSPlacedUpdateInfo(planetIdx: planetIdx, coords: Coords.fromJson(json)),
      _ => throw const FormatException('Failed to Load PDSPlacedUpdate')
    };
  }
}