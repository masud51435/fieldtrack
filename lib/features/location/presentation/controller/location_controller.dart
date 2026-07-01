import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/usecases/get_all_location_usecases.dart';

class LocationController extends GetxController {
  final GetAllLocationUseCases getAllLocationUseCases;
  LocationController({required this.getAllLocationUseCases});

  final isLoading = false.obs;
  final allLocations = <LocationEntity>[].obs;
  final filteredLocations = <LocationEntity>[].obs;
  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchLocations();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void onClose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.onClose();
  }

  Future<void> fetchLocations() async {
    isLoading.value = true;
    try {
      final result = await getAllLocationUseCases(NoParams());
      allLocations.assignAll(result.locations);
      filteredLocations.assignAll(result.locations);
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Location Load Error: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredLocations.assignAll(allLocations);
    } else {
      filteredLocations.assignAll(
        allLocations
            .where((loc) => loc.locationName.toLowerCase().contains(query))
            .toList(),
      );
    }
  }

  Future<void> refreshLocations() async {
    await fetchLocations();
  }
}
