import '../../../../core/usecases/usecase.dart';
import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

class UpdateTodoUseCase implements UseCase<TodoEntity, UpdateTodoParams> {
  final HomeRepository repository;

  UpdateTodoUseCase(this.repository);

  @override
  Future<TodoEntity> call(UpdateTodoParams params) async {
    return await repository.updateTodo(
      params.id,
      params.isCompleted,
      params.updatedAt,
    );
  }
}

class UpdateTodoParams {
  final String id;
  final bool isCompleted;
  final String updatedAt;

  UpdateTodoParams({
    required this.id,
    required this.isCompleted,
    required this.updatedAt,
  });
}
