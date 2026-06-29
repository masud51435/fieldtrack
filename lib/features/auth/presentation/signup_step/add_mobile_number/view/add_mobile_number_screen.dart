import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../controller/add_mobile_number_controller.dart';

class AddMobileNumberScreen extends GetView<AddMobileNumberController> {
  const AddMobileNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add your mobile number to get started',
              style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                // Country Code Selector
                GestureDetector(
                  onTap: () => _showCountryPicker(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Obx(
                      () => Text(
                        controller.selectedCountry.value?.dialCode ?? '+00',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Phone Number Input
                Expanded(
                  child: TextFormField(
                    controller: controller.phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(hintText: 'Phone Number'),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Select Country',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.countryList.length,
                  itemBuilder: (context, index) {
                    final country = controller.countryList[index];
                    return ListTile(
                      title: Text(country.name),
                      trailing: Text(country.dialCode),
                      onTap: () => controller.selectCountry(country),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
