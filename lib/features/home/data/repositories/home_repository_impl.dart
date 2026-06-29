import '../../domain/entities/home_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<HomeEntity> getHomeData() async {
    final response = await remoteDataSource.getHomeData();
    return response.toEntity();
  }
}
