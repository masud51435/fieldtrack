class CountryEntity {
  final String name;
  final String code;
  final String dialCode;
  final bool selected;

  CountryEntity({
    required this.name,
    required this.code,
    required this.dialCode,
    this.selected = false,
  });
}
