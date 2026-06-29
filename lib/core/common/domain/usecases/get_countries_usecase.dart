import '../../../usecases/usecase.dart';
import '../entities/country_entity.dart';
import '../repositories/common_repository.dart';

class GetCountriesUseCase implements UseCase<List<CountryEntity>, NoParams> {
  final CommonRepository repository;

  GetCountriesUseCase(this.repository);

  @override
  Future<List<CountryEntity>> call(NoParams params) async {
    return await repository.getCountries();
  }
}
