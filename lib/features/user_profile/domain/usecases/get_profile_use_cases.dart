import '../../../../core/usecases/usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetProfileUseCases implements UseCase<ProfileEntity, NoParams> {
  ProfileRepository repository;
  GetProfileUseCases(this.repository);

  @override
  Future<ProfileEntity> call(NoParams params) async {
    return await repository.getProfile();
  }
}
