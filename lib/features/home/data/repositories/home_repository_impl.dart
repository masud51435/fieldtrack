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

  @override
  Future<TodoEntity> updateTodo(
    String id,
    bool isCompleted,
    String updatedAt,
  ) async {
    final response = await remoteDataSource.updateTodo(
      id,
      isCompleted,
      updatedAt,
    );
    return response.toEntity();
  }

  @override
  Future<Map<String, dynamic>> syncTodos(
    List<Map<String, dynamic>> changes,
  ) async {
    return await remoteDataSource.syncTodos(changes);
  }
}
