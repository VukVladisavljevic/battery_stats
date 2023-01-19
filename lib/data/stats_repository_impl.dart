import 'package:battery_stats/data/stats_source.dart';
import 'package:battery_stats/domain/stats/stats_repository.dart';

class StatsRepositoryImpl implements StatsRepository {
  final StatsSource _statsSource;

  StatsRepositoryImpl(this._statsSource);

  @override
  Stream<dynamic> getBatteryLevel() => _statsSource.getBatteryLevel();
}
