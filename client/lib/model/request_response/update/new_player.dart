import 'package:client/model/request_response/update/update.dart';

class NewPlayerUpdateInfo implements UpdateInfo {
  String race;
  NewPlayerUpdateInfo({
    required this.race
  });

  factory NewPlayerUpdateInfo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'race': String race,
      } =>
        NewPlayerUpdateInfo(race: race),
      _ => throw const FormatException('Failed to load NewPlayerUpdateInfo.'),
    };
  }

}