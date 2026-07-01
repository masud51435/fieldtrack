import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/snackbar/toast_service.dart';
import '../../data/models/add_new_location_request_model.dart';
import '../../domain/usecases/add_new_location_usecases.dart';

class AddLocationController extends GetxController {
  final AddNewLocationUseCases addNewLocationUseCase;

  AddLocationController({required this.addNewLocationUseCase});

  final nameController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();

  var radius = 150.0.obs;
  var isActive = true.obs;
  var isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    nameController.dispose();
    latController.dispose();
    lngController.dispose();
    super.onClose();
  }

  void updateRadius(double value) {
    radius.value = value;
  }

  void toggleActive(bool value) {
    isActive.value = value;
  }

  Future<void> getCurrentLocation() async {
    // This will be implemented once geolocator is added
    // For now, setting some dummy values or showing a toast
    ToastService.showSuccess("Fetching current location...");

    // Simulating location fetch
    await Future.delayed(const Duration(seconds: 1));
    latController.text = "25.2048";
    lngController.text = "55.2708";
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
      Get.back(result: true);
      ToastService.showSuccess("Location saved successfully");
    } catch (e) {
      debugPrint("Error saving location: $e");
      // Error handling is usually done in interceptor/handler
    } finally {
      isLoading.value = false;
    }
  }
}
