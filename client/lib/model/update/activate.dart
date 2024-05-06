import 'package:client/model/update/update.dart';

class ActivateUpdateInfo implements UpdateInfo {

  ActivateUpdateInfo({
    required this.x,
    required this.y
  });

  int x;
  int y;


  factory ActivateUpdateInfo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'x': int x,
        'y': int y
      } =>
        ActivateUpdateInfo(x: x, y: y),
      _ => throw const FormatException('Failed to load ActivateUpdateInfo.'),
    };
  }
}