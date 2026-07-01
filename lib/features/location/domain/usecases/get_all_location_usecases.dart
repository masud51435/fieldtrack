import '../../../../core/usecases/usecase.dart';
import '../entities/location_entity.dart';
import '../repositories/location_repository.dart';

class GetAllLocationUseCases implements UseCase<AllLocationsEntity, NoParams> {
  final LocationRepository repository;
  GetAllLocationUseCases(this.repository);

  @override
  Future<AllLocationsEntity> call(NoParams params) async {
    return await repository.getLocation();
  }
}
