import 'package:age_of_style/features/domain/entity/settings.dart';

class SettingsModel extends SettingsEntity {
  SettingsModel({
    required DateTime starts,
    required DateTime ends,
  }) : super(starts: starts, ends: ends);

  factory SettingsModel.fromJson(Map<String, dynamic> map) {
    return SettingsModel(
      starts: DateTime.parse(map['created_at']),
      ends: DateTime.parse(map['updated_at']),
    );
  }
}
