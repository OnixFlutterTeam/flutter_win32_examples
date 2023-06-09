import 'package:flutter_win32_examples/domain/wifi_connection.dart';

class WiFiAdapter {
  final String guid;
  final String desc;
  final connections = <WiFiConnection>[];

  WiFiAdapter(this.guid, this.desc);

  @override
  String toString() {
    return 'WiFiAdapter{guid: $guid, desc: $desc, connections: $connections}';
  }
}
