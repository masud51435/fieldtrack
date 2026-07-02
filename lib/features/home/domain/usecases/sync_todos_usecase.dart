import '../../../../core/usecases/usecase.dart';
import '../repositories/home_repository.dart';

class SyncTodosUseCase
    implements UseCase<Map<String, dynamic>, List<Map<String, dynamic>>> {
  final HomeRepository repository;

  SyncTodosUseCase(this.repository);

  @override
  Future<Map<String, dynamic>> call(List<Map<String, dynamic>> params) async {
    return await repository.syncTodos(params);
  }
}
