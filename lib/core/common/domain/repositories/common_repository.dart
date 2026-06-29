import '../entities/country_entity.dart';

abstract class CommonRepository {
  Future<List<CountryEntity>> getCountries();
}
