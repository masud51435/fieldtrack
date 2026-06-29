import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../app/routes/routes.dart';
import '../../../../../../core/common/domain/entities/country_entity.dart';
import '../../../../../../core/common/domain/usecases/get_countries_usecase.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../../../../../core/utils/device/device_utility.dart';
import '../../../../../../core/utils/snackbar/toast_service.dart';
import '../../../../domain/usecases/send_registration_otp_usecase.dart';

class AddMobileNumberController extends GetxController {
  final GetCountriesUseCase getCountriesUseCase;
  final SendRegistrationOtpUseCase sendRegistrationOtpUseCase;

  AddMobileNumberController({
    required this.getCountriesUseCase,
    required this.sendRegistrationOtpUseCase,
  });

  final phoneController = TextEditingController();
  final countryCodeController = TextEditingController();
  var isLoading = false.obs;

  var countryList = <CountryEntity>[].obs;
  var selectedCountry = Rxn<CountryEntity>();

  @override
  void onInit() {
    super.onInit();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    try {
      final countries = await getCountriesUseCase(NoParams());
      countryList.assignAll(countries);

      if (countryList.isNotEmpty) {
        selectedCountry.value = countryList.firstWhere(
          (c) => c.selected,
          orElse: () => countryList.first,
        );
        countryCodeController.text = selectedCountry.value?.dialCode ?? '';
      }
    } catch (e) {
      // Handled globally
    }
  }

  void selectCountry(CountryEntity country) {
    selectedCountry.value = country;
    countryCodeController.text = country.dialCode;
    Get.back(); // Close bottom sheet
  }

  Future<void> onSubmit() async {
    if (phoneController.text.isEmpty) {
      ToastService.showError('Please enter phone number');
      return;
    }

    DeviceUtility.hideKeyboard();
    isLoading.value = true;

    try {
      final message = await sendRegistrationOtpUseCase(
        RegistrationOtpParams(
          phoneNumber: phoneController.text.trim(),
          dialCode: countryCodeController.text.trim(),
        ),
      );

      ToastService.showSuccess(message);

      Get.toNamed(
        BaseRoute.verifyOtp,
        arguments: {
          'dialCode': countryCodeController.text,
          'phoneNumber': phoneController.text,
          'type': 'registration',
        },
      );
    } catch (e) {
      // Handled globally
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    countryCodeController.dispose();
    super.onClose();
  }
}
