import '../../../../core/usecases/usecase.dart';
import '../repositories/home_repository.dart';

class SyncTodosUseCase implements UseCase<void, List<Map<String, dynamic>>> {
  final HomeRepository repository;

  SyncTodosUseCase(this.repository);

  @override
  Future<void> call(List<Map<String, dynamic>> params) async {
    return await repository.syncTodos(params);
  }
}
