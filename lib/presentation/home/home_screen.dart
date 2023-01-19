
import 'package:battery_stats/main.dart';
import 'package:battery_stats/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _homeViewModel = getIt();

  @override
  void initState() {
    super.initState();
    _homeViewModel.startListeningBatteryStatus();
  }

  @override
  void dispose() {
    _homeViewModel.stopListeningBatteryStatus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (context) => _homeViewModel,
        child: Consumer<HomeViewModel>(builder: (context, value, __) => _buildScreenContent(context, value)),
      ),
    );
  }

  Widget _buildScreenContent(BuildContext context, HomeViewModel viewModel) {
    return Center(child: Text(viewModel.batteryLevel.toString()));
  }
}
