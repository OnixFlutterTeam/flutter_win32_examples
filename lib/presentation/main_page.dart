import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_win32_examples/domain/wifi_service.dart';
import 'package:flutter_win32_examples/presentation/renderers/wifi_adapter_renderer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with AfterLayoutMixin {
  final _wifiService = WiFiService();
  final _data = <WiFiAdapterRenderer>[];
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('WiFi'),
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _data.map((adapter) => adapter.render(context)).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    _onTimerTik();
    _timer = Timer.periodic(
      const Duration(milliseconds: 10000),
      (_) => _onTimerTik(),
    );
  }

  void _onTimerTik() async {
    setState(() {
      _data.clear();
      try {
        _data.addAll(_wifiService
            .getWiFiInfo()
            .map((item) => WiFiAdapterRenderer(item))
            .toList());
      } catch (e) {
        print(e);
      }
    });
  }
}
