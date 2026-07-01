import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../utils/snackbar/toast_service.dart';

class NetworkService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  final RxBool isConnected = true.obs;
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  Future<NetworkService> init() async {
    // Initial check
    final List<ConnectivityResult> result = await _connectivity
        .checkConnectivity();
    _updateState(result);

    // Listen to changes
    _subscription = _connectivity.onConnectivityChanged.listen(_updateState);
    return this;
  }

  void _updateState(List<ConnectivityResult> result) {
    final bool currentlyConnected = !result.contains(ConnectivityResult.none);

    // Show a toast only when status changes from online to offline
    if (isConnected.value && !currentlyConnected) {
      ToastService.showError("You are offline. Some features may be limited.");
    } else if (!isConnected.value && currentlyConnected) {
      ToastService.showSuccess("You are back online!");
    }

    isConnected.value = currentlyConnected;
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
