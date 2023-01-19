import 'package:battery_stats/main.dart';
import 'package:battery_stats/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _homeViewModel = getIt();

  final TextEditingController _textEditingController = TextEditingController();

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
        child: Consumer<HomeViewModel>(
          builder: (_, value, __) => _buildScreenContent(value),
        ),
      ),
    );
  }

  Widget _buildScreenContent(HomeViewModel viewModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildActionButton(viewModel),
            const SizedBox(height: 12.0),
            _buildBatteryLevelLabel(viewModel),
            const SizedBox(height: 12.0),
            _buildThresholdInput(viewModel),
            const SizedBox(height: 12.0),
            _manageThresholdButton(viewModel),
            const SizedBox(height: 12.0),
            _buildAlertLabel(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(HomeViewModel viewModel) {
    final buttonLabel = viewModel.isListening ? "Stop listening to battery level" : "Start listening to battery level";
    final action = viewModel.isListening ? viewModel.stopListeningBatteryStatus : viewModel.startListeningBatteryStatus;

    return ElevatedButton(
      onPressed: action,
      child: Text(buttonLabel),
    );
  }

  Widget _buildBatteryLevelLabel(HomeViewModel viewModel) {
    var batteryLabel = viewModel.batteryLevel != null ? "${viewModel.batteryLevel?.round()}%" : "Info not available";

    return RichText(
        // ignore: prefer_const_constructors
        text: TextSpan(
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
            // ignore: prefer_const_literals_to_create_immutables
            children: <TextSpan>[
          const TextSpan(text: "Current battery level: "),
          TextSpan(text: batteryLabel, style: const TextStyle(fontWeight: FontWeight.bold)),
        ]));
  }

  Widget _buildThresholdInput(HomeViewModel viewModel) {
    return TextField(
      decoration: const InputDecoration(labelText: "Enter threshold value"),
      controller: _textEditingController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
    );
  }

  Widget _manageThresholdButton(HomeViewModel viewModel) {
    return ElevatedButton(
      onPressed: () {
        viewModel.isThresholdActive
            ? viewModel.removeThreshold()
            : viewModel.setThreshold(double.parse(_textEditingController.text));
      },
      child: viewModel.isThresholdActive ? const Text("Remove") : const Text("Set"),
    );
  }

  Widget _buildAlertLabel(HomeViewModel viewModel) => (viewModel.showAlert && viewModel.isThresholdActive)
      ? Text(
          "Battery level is now below value set to: ${viewModel.threshold}",
          style: const TextStyle(color: Colors.red),
        )
      : const SizedBox.shrink();
}
