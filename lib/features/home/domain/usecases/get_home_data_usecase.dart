import '../../../../core/usecases/usecase.dart';
import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

class GetHomeDataUseCase implements UseCase<HomeEntity, NoParams> {
  final HomeRepository repository;

  GetHomeDataUseCase(this.repository);

  @override
  Future<HomeEntity> call(NoParams params) async {
    return await repository.getHomeData();
  }
}
