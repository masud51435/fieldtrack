import '../../../../core/usecases/usecase.dart';
import '../../data/models/add_new_location_request_model.dart';
import '../entities/location_entity.dart';
import '../repositories/location_repository.dart';

class UpdateLocationUseCase
    implements UseCase<LocationEntity, UpdateLocationParams> {
  final LocationRepository repository;
  UpdateLocationUseCase(this.repository);

  @override
  Future<LocationEntity> call(UpdateLocationParams params) {
    return repository.updateLocation(params.id, params.request);
  }
}

class UpdateLocationParams {
  final String id;
  final AddNewLocationRequestModel request;

  UpdateLocationParams({required this.id, required this.request});
}
