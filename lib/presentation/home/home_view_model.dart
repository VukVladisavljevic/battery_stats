import 'dart:async';

import 'package:battery_stats/domain/stats/get_battery_stats_usecase.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final GetBatteryLevelUsecase _getBatteryLevelUsecase;

  HomeViewModel(this._getBatteryLevelUsecase);

  double? batteryLevel;
  double? threshold;
  bool showAlert = false;
  StreamSubscription? _streamSubscription;

  bool get isListening => _streamSubscription != null;
  bool get isThresholdActive => (threshold != null && isListening);

  void startListeningBatteryStatus() {
    _streamSubscription ??= _getBatteryLevelUsecase.call().listen((event) => _updateBatteryLevel(event));
  }

  void stopListeningBatteryStatus() {
    if (_streamSubscription != null) {
      _streamSubscription?.cancel();
      _streamSubscription = null;
    }

    removeThreshold();
    batteryLevel = null;
    deferredNotify();
  }

  void setThreshold(double value) {
    if (value > 0 && value < 100) {
      threshold = value;
      // showAlert = true;
    }
    notifyListeners();
  }

  void removeThreshold() {
    threshold = null;
    showAlert = false;
    notifyListeners();
  }

  void _updateBatteryLevel(dynamic value) {
    batteryLevel = value;

    if (isThresholdActive) {
      if (value < threshold) {
        showAlert = true;
      }

      if (value > threshold) {
        showAlert = false;
      }
    }
    deferredNotify();
  }

  /// This enables successive runs of notifyListeners() within same function
  void deferredNotify() => Future.delayed(
        Duration.zero,
        () async {
          notifyListeners();
        },
      );
}
