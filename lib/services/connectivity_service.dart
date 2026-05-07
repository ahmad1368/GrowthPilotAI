import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

class ConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();

  // وضعیت آنلاین بودن
  final isOnline = true.obs;

  // وضعیت نمایش آیکون سینک
  final showSyncIcon = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _checkInitialConnection() async {
    // در نسخه جدید این متد یک List<ConnectivityResult> برمی‌گرداند
    final List<ConnectivityResult> result =
        await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    // اگر هیچ اتصالی نباشد
    if (results.contains(ConnectivityResult.none)) {
      isOnline.value = false;
    } else {
      // اگر قبلاً آفلاین بوده و حالا آنلاین شده، انیمیشن سینک فعال شود
      if (isOnline.value == false) {
        showSyncIcon.value = true;
      }
      isOnline.value = true;
    }
  }

  void onUserInteraction() {
    // به محض اولین اکشن کاربر، آیکون محو شود
    if (showSyncIcon.value) {
      showSyncIcon.value = false;
    }
  }
}
