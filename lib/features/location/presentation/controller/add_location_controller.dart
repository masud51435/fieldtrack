import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../../core/services/geofence_service.dart';
import '../../../../core/utils/snackbar/toast_service.dart';
import '../../data/models/add_new_location_request_model.dart';
import '../../domain/usecases/add_new_location_usecases.dart';

class AddLocationController extends GetxController {
  final AddNewLocationUseCases addNewLocationUseCase;

  AddLocationController({required this.addNewLocationUseCase});

  final nameController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();

  final radius = 150.0.obs;
  final isActive = true.obs;
  final isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    nameController.dispose();
    latController.dispose();
    lngController.dispose();
    super.onClose();
  }

  void updateRadius(double value) => radius.value = value;

  void toggleActive(bool value) => isActive.value = value;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      if (permission == LocationPermission.deniedForever) {
        ToastService.showError(
          "Location permissions are permanently denied. Please enable them in settings.",
        );
        return;
      }

      ToastService.showSuccess("Fetching current location...");

      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      latController.text = position.latitude.toStringAsFixed(6);
      lngController.text = position.longitude.toStringAsFixed(6);
    } catch (e) {
      ToastService.showError("Could not fetch location: $e");
    }
  }

  Future<void> saveLocation() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final request = AddNewLocationRequestModel(
        locationName: nameController.text.trim(),
        latitude: double.parse(latController.text),
        longitude: double.parse(lngController.text),
        radiusM: radius.value,
        isActive: isActive.value,
      );

      await addNewLocationUseCase(request);

      // Refresh Geofence monitoring if active
      if (Get.isRegistered<GeofenceService>()) {
        await Get.find<GeofenceService>().updateMonitoredLocations();
      }

      Get.back(result: true);
      ToastService.showSuccess("Location saved successfully");
    } catch (e) {
      debugPrint("Error saving location: $e");
      ToastService.showError("Failed to save location. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
