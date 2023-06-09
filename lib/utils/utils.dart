import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:win32/win32.dart';

typedef OnCall = dynamic Function(List arguments);

class VarargsFunction {
  VarargsFunction(this._onCall);

  final OnCall _onCall;

  @override
  noSuchMethod(Invocation invocation) {
    if (!invocation.isMethod || invocation.namedArguments.isNotEmpty) {
      super.noSuchMethod(invocation);
    }
    final arguments = invocation.positionalArguments;
    return _onCall(arguments);
  }
}

final logg = VarargsFunction((arguments) {
  for (final item in arguments) {
    if (kDebugMode) {
      print('$item');
    }
  }
}) as dynamic;

double parseIRSSI(int wlanSignalQuality) {
  late double iRSSI;
  if (wlanSignalQuality == 0) {
    iRSSI = -100;
  } else if (wlanSignalQuality == 100) {
    iRSSI = -50;
  } else {
    iRSSI = -100 + (wlanSignalQuality / 2);
  }
  return iRSSI;
}

String getSSIDName(DOT11_SSID ssid) {
  final charCodes = <int>[];
  for (var i = 0; i < ssid.uSSIDLength; i++) {
    if (ssid.ucSSID[i] == 0x00) break;
    charCodes.add(ssid.ucSSID[i]);
  }
  return String.fromCharCodes(charCodes);
}
