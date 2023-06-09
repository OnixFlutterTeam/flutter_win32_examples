class WiFiConnection {
  final String ssid;
  final String profileName;
  final double iRSSI;
  final bool isSecurityEnabled;
  final int algCode;

  WiFiConnection({
    required this.ssid,
    required this.profileName,
    required this.iRSSI,
    required this.isSecurityEnabled,
    required this.algCode,
  });

  String get alg {
    switch (algCode) {
      case 1:
        return 'DOT11_AUTH_ALGO_80211_OPEN';
      case 2:
        return 'DOT11_AUTH_ALGO_80211_SHARED_KEY';
      case 3:
        return 'DOT11_AUTH_ALGO_WPA';
      case 4:
        return 'DOT11_AUTH_ALGO_WPA_PSK';
      case 5:
        return 'DOT11_AUTH_ALGO_WPA_NONE';
      case 6:
        return 'DOT11_AUTH_ALGO_RSNA';
      case 7:
      case 8:
        return 'DOT11_AUTH_ALGO_RSNA_PSK';
      case 9:
        return 'DOT11_AUTH_ALGO_WPA3_SAE';
      case 10:
        return 'DOT11_AUTH_ALGO_OWE';
      case 11:
        return 'DOT11_AUTH_ALGO_WPA3_ENT';
      case 0x80000000:
        return 'DOT11_AUTH_ALGO_IHV_START';
      case 0xffffffff:
        return 'DOT11_AUTH_ALGO_IHV_END';
      default:
        return 'UNKNOWN';
    }
  }

  @override
  String toString() {
    return 'WiFiConnection{ssid: $ssid, profileName: $profileName, iRSSI: $iRSSI, isSecurityEnabled: $isSecurityEnabled, alg: $alg}';
  }
}
