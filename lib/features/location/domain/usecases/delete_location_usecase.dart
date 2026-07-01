import '../../../../core/usecases/usecase.dart';
import '../repositories/location_repository.dart';

class DeleteLocationUseCase implements UseCase<void, String> {
  final LocationRepository repository;

  DeleteLocationUseCase(this.repository);

  @override
  Future<void> call(String id) async {
    return await repository.deleteLocation(id);
  }
}
