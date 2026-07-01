import '../../../../core/usecases/usecase.dart';
import '../../data/models/add_new_location_request_model.dart';
import '../entities/location_entity.dart';
import '../repositories/location_repository.dart';

class AddNewLocationUseCases
    implements UseCase<LocationEntity, AddNewLocationRequestModel> {
  final LocationRepository repository;
  AddNewLocationUseCases(this.repository);

  @override
  Future<LocationEntity> call(AddNewLocationRequestModel request) {
    return repository.addNewLocation(request);
  }
}
