import 'package:flutter/services.dart';

abstract class StatsSource {
  Stream<dynamic> getBatteryLevel();
}

class StatsSourceImpl implements StatsSource {
  final channel = const EventChannel("battery_stats");

  @override
  Stream<dynamic> getBatteryLevel() => channel.receiveBroadcastStream();
  
}
