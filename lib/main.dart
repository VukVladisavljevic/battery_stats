import 'package:battery_stats/di_setup.dart' as di_setup;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'presentation/home/home_screen.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  di_setup.setupInjections();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      );
}
