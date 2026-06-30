import '../../../../core/network/api_client.dart';
import '../../../../core/network/method_types.dart';
import '../models/home_response_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeResponseModel> getHomeData();
  Future<Todo> updateTodo(String id, bool isCompleted, String updatedAt);
  Future<void> syncTodos(List<Map<String, dynamic>> changes);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient client;

  HomeRemoteDataSourceImpl({required this.client});

  @override
  Future<HomeResponseModel> getHomeData() async {
    return await client.request(
      path: "/todos",
      method: MethodType.get,
      parse: (json) => HomeResponseModel.fromJson(json),
    );
  }

  @override
  Future<Todo> updateTodo(String id, bool isCompleted, String updatedAt) async {
    return await client.request(
      path: "/todos/$id",
      method: MethodType.patch,
      payload: {'is_completed': isCompleted, 'updated_at': updatedAt},
      parse: (json) {
        final todoJson = json['data'] ?? json;
        return Todo.fromJson(todoJson);
      },
    );
  }

  @override
  Future<void> syncTodos(List<Map<String, dynamic>> changes) async {
    await client.request(
      path: "/todos/sync",
      method: MethodType.post,
      payload: {'changes': changes},
      parse: (json) => json,
    );
  }
}
