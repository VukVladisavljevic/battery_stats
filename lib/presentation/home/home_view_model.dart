import 'dart:async';
import 'dart:developer';

import 'package:battery_stats/domain/stats/get_battery_stats_usecase.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final GetBatteryLevelUsecase _getBatteryLevelUsecase;

  double batteryLevel = 0.0;
  bool isDataAvailable = false;

  late final StreamSubscription _streamSubscription;

  HomeViewModel(this._getBatteryLevelUsecase);

  void startListeningBatteryStatus() {
    _streamSubscription =
        _getBatteryLevelUsecase.call().listen(((event) => _presentData(event)));
  }

  void stopListeningBatteryStatus() => _streamSubscription.cancel();

  void _presentData(dynamic value) {
    if (value == null) {
      isDataAvailable = false;
      return;
    } else {
      batteryLevel = value + .0;
    }

    log('Novi event sa' + batteryLevel.toString());
    notifyListeners();
  }
}
