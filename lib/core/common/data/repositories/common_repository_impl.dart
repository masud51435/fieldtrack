import '../../domain/entities/country_entity.dart';
import '../../domain/repositories/common_repository.dart';
import '../datasources/common_remote_data_source.dart';

class CommonRepositoryImpl implements CommonRepository {
  final CommonRemoteDataSource remoteDataSource;

  CommonRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CountryEntity>> getCountries() async {
    final response = await remoteDataSource.getCountries();
    return response.data ?? [];
  }
}
