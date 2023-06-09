import 'package:flutter/material.dart';
import 'package:flutter_win32_examples/presentation/renderers/irenderable.dart';
import 'package:flutter_win32_examples/domain/wifi_connection.dart';

class WiFiConnectionRenderer extends IRenderable<WiFiConnection> {
  WiFiConnectionRenderer(super.model);

  @override
  Widget render(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('SSID: ${model.ssid}'),
          Text('iRSSI: ${model.iRSSI}'),
          Text('Saved profile: ${model.profileName}'),
          Text('SecurityEnabled: ${model.isSecurityEnabled}'),
          Text('Algorithm: ${model.alg}'),
        ],
      ),
    );
  }
}
