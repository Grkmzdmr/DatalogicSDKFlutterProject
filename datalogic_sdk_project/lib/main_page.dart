import 'dart:async';

import 'package:datalogic_sdk_project/app_strings.dart';
import 'package:datalogic_sdk_project/services/datalogic_service.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final DataLogicService _service = DataLogicServiceImpl();

  final StreamController<String> _serialNumberStreamController =
      StreamController<String>();

  @override
  void initState() {
    _service.getDeviceInfo().then((value) =>
        _serialNumberStreamController.sink.add(value.substring(0, 3) + 'XXXX'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(
            flex: 3,
          ),
          StreamBuilder<String>(
              stream: _serialNumberStreamController.stream,
              builder: (context, snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 2,
                    ),
                    Text(
                      AppStrings.deviceInfo,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    Text(
                      snapshot.data ?? AppStrings.error,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                );
              }),
          const Spacer(),
          Row(
            children: [
              const Spacer(
                flex: 2,
              ),
              ElevatedButton(
                  onPressed: () {
                    _service.openScanner();
                  },
                  child: Text(AppStrings.scannerOpen)),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    _service.closeScanner();
                  },
                  child: Text(AppStrings.scannerClose)),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                _service.closeAutoScanner();
              },
              child: Text(AppStrings.autoScannerClose)),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
