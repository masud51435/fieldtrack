import '../../domain/entities/country_entity.dart';

class CountryModel extends CountryEntity {
  CountryModel({
    required super.name,
    required super.code,
    required super.dialCode,
    super.selected,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      dialCode: json['dial_code'] ?? '',
      selected: json['selected'] ?? false,
    );
  }
}
