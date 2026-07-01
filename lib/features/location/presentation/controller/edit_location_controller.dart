import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../../core/services/geofence_service.dart';
import '../../../../core/utils/snackbar/toast_service.dart';
import '../../data/models/add_new_location_request_model.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/usecases/delete_location_usecase.dart';
import '../../domain/usecases/update_location_usecase.dart';

class EditLocationController extends GetxController {
  final UpdateLocationUseCase updateLocationUseCase;
  final DeleteLocationUseCase deleteLocationUseCase;

  EditLocationController({
    required this.updateLocationUseCase,
    required this.deleteLocationUseCase,
  });

  late LocationEntity location;

  final nameController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();

  final radius = 150.0.obs;
  final isActive = true.obs;
  final isLoading = false.obs;
  final isDeleting = false.obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is LocationEntity) {
      location = Get.arguments as LocationEntity;
      _initializeFields();
    } else {
      // Small delay to ensure snackbar shows or use future
      Future.delayed(Duration.zero, () {
        Get.back();
        ToastService.showError("Invalid location data");
      });
    }
  }

  void _initializeFields() {
    nameController.text = location.locationName;
    latController.text = location.latitude.toString();
    lngController.text = location.longitude.toString();
    radius.value = location.radiusM;
    isActive.value = location.isActive;
  }

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
        ToastService.showError("Location permissions are permanently denied.");
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

  Future<void> updateLocation() async {
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

      await updateLocationUseCase(
        UpdateLocationParams(id: location.id, request: request),
      );

      if (Get.isRegistered<GeofenceService>()) {
        await Get.find<GeofenceService>().updateMonitoredLocations();
      }

      Get.back(result: true);
      ToastService.showSuccess("Location updated successfully");
    } catch (e) {
      debugPrint("Error updating location: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteLocation() async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text("Delete Location"),
        content: const Text("Are you sure you want to delete this location?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    isDeleting.value = true;
    try {
      await deleteLocationUseCase(location.id);

      if (Get.isRegistered<GeofenceService>()) {
        await Get.find<GeofenceService>().updateMonitoredLocations();
      }

      Get.back(result: true);
      ToastService.showSuccess("Location deleted successfully");
    } catch (e) {
      debugPrint("Error deleting location: $e");
    } finally {
      isDeleting.value = false;
    }
  }
}
