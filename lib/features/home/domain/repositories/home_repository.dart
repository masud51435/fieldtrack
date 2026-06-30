import '../entities/home_entity.dart';

abstract class HomeRepository {
  Future<HomeEntity> getHomeData();
  Future<TodoEntity> updateTodo(String id, bool isCompleted, String updatedAt);
  Future<void> syncTodos(List<Map<String, dynamic>> changes);
}
