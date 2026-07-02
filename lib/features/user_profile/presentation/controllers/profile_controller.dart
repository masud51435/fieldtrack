import 'package:get/get.dart';

import '../../../../app/routes/routes.dart';
import '../../../../core/services/geofence_service.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../auth/domain/usecases/logout_usecase.dart';
import '../../../home/presentation/controller/home_controller.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/usecases/get_profile_use_cases.dart';

class ProfileController extends GetxController {
  final GetProfileUseCases getProfileUseCases;
  final LogoutUseCase logoutUseCase;

  ProfileController({
    required this.getProfileUseCases,
    required this.logoutUseCase,
  });

  final profile = Rxn<ProfileEntity>();
  final isLoading = false.obs;
  final isLoggingOut = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      final result = await getProfileUseCases(NoParams());
      profile.value = result;
    } catch (e) {
      // Errors are handled by ApiErrorHandler + ToastService automatically
    } finally {
      isLoading.value = false;
    }
  }

  String get initials {
    if (profile.value == null || profile.value!.name.isEmpty) return '??';
    List<String> names = profile.value!.name.split(' ');
    if (names.length >= 2) {
      return (names[0][0] + names[1][0]).toUpperCase();
    }
    return names[0][0].toUpperCase();
  }

  int get completedTasks => Get.find<HomeController>().completedCount;
  int get totalTasks => Get.find<HomeController>().totalCount;

  // Dynamic active locations count
  int get activeLocationsCount =>
      Get.find<GeofenceService>().monitoredLocations.length;

  // Logout method
  Future<void> logout() async {
    isLoggingOut.value = true;
    try {
      await logoutUseCase(NoParams());
      Get.offAllNamed(BaseRoute.login);
    } catch (e) {
      // Errors are handled by ApiErrorHandler + ToastService automatically
    } finally {
      isLoggingOut.value = false;
    }
  }
}
