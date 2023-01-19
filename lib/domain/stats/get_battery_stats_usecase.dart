import 'package:battery_stats/domain/stats/stats_repository.dart';

class GetBatteryLevelUsecase {
  final StatsRepository _statsRepository;

  GetBatteryLevelUsecase(this._statsRepository);

  Stream<dynamic> call() => _statsRepository.getBatteryLevel();
}
