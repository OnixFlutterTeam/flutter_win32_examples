import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter_win32_examples/utils/utils.dart';
import 'package:flutter_win32_examples/domain/wifi_adapter.dart';
import 'package:flutter_win32_examples/domain/wifi_connection.dart';
import 'package:win32/win32.dart';

class WiFiService {
  /// Throws Exception
  List<WiFiAdapter> getWiFiInfo() {
    final pdwNegotiatedVersion = calloc<Uint32>();
    final phClientHandle = calloc<IntPtr>();
    final ppInterfaceList = calloc<Pointer<WLAN_INTERFACE_INFO_LIST>>();
    final ppAvailableNetworkList =
        calloc<Pointer<WLAN_AVAILABLE_NETWORK_LIST>>();
    final pInterfaceGuid = calloc<GUID>();
    final adapters = <WiFiAdapter>[];

    try {
      final wlanOpenHandle = WlanOpenHandle(
        2,
        nullptr,
        pdwNegotiatedVersion,
        phClientHandle,
      );
      if (!SUCCEEDED(wlanOpenHandle)) {
        throw Exception('NOT SUCCEEDED');
      }

      final wlanEnumInterfaces = WlanEnumInterfaces(
        phClientHandle.value,
        nullptr,
        ppInterfaceList,
      );
      if (!SUCCEEDED(wlanEnumInterfaces)) {
        throw Exception('NOT SUCCEEDED');
      }
      logg('WlanEnumInterfaces: ${ppInterfaceList.value.ref.dwNumberOfItems}');

      for (var i = 0; i < ppInterfaceList.value.ref.dwNumberOfItems; i++) {
        final interface = ppInterfaceList.value.ref.InterfaceInfo[i];
        print('interface $i: ${interface.strInterfaceDescription}');

        final guidString = interface.InterfaceGuid.toString();
        final adapterItem =
            WiFiAdapter(guidString, interface.strInterfaceDescription);
        pInterfaceGuid.ref.setGUID(guidString);

        try {
          final wlanGetAvailableNetworkList = WlanGetAvailableNetworkList(
            phClientHandle.value,
            pInterfaceGuid,
            0x00000001,
            nullptr,
            ppAvailableNetworkList,
          );
          if (!SUCCEEDED(wlanGetAvailableNetworkList)) {
            throw Exception('NOT SUCCEEDED');
          }
          logg('interface $i has available connections: '
              '${ppAvailableNetworkList.value.ref.dwNumberOfItems}');

          for (var j = 0;
              j < ppAvailableNetworkList.value.ref.dwNumberOfItems;
              j++) {
            final network = ppAvailableNetworkList.value.ref.Network[j];
            final connection = WiFiConnection(
              ssid: getSSIDName(network.dot11Ssid),
              profileName: network.strProfileName.isEmpty
                  ? 'not saved'
                  : network.strProfileName,
              iRSSI: parseIRSSI(network.wlanSignalQuality),
              isSecurityEnabled: network.bSecurityEnabled > 0,
              algCode: network.dot11DefaultAuthAlgorithm,
            );
            adapterItem.connections.add(connection);
            logg(connection);
          }
          adapters.add(adapterItem);
        } catch (e) {
          logg(e);
        }
      }
      return adapters;
    } catch (e) {
      logg(e);
      return [];
    } finally {
      WlanCloseHandle(phClientHandle.value, nullptr);
      free(pInterfaceGuid);
      free(ppAvailableNetworkList);
      free(pdwNegotiatedVersion);
      free(phClientHandle);
      free(ppInterfaceList);
    }
  }
}
