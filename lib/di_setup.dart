import 'package:battery_stats/data/stats_repository_impl.dart';
import 'package:battery_stats/domain/stats/get_battery_stats_usecase.dart';
import 'package:battery_stats/domain/stats/stats_repository.dart';
import 'package:battery_stats/main.dart';
import 'package:battery_stats/presentation/home/home_view_model.dart';

import 'data/stats_source.dart';

void setupInjections() {
  getIt.registerSingleton<StatsSource>(StatsSourceImpl());

  getIt.registerSingleton<StatsRepository>(StatsRepositoryImpl(getIt()));

  getIt.registerFactory<GetBatteryLevelUsecase>(() => GetBatteryLevelUsecase(getIt()));

  getIt.registerSingleton<HomeViewModel>(HomeViewModel(getIt()));
}
