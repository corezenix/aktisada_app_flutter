import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils {
  static Future<bool> hasInternetConnection() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      }

      // Try to reach a reliable host
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  static Future<ConnectivityResult> getConnectivityStatus() async {
    return await Connectivity().checkConnectivity();
  }

  static String getConnectivityMessage(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return 'Connected to WiFi';
      case ConnectivityResult.mobile:
        return 'Connected to Mobile Data';
      case ConnectivityResult.ethernet:
        return 'Connected to Ethernet';
      case ConnectivityResult.vpn:
        return 'Connected via VPN';
      case ConnectivityResult.bluetooth:
        return 'Connected via Bluetooth';
      case ConnectivityResult.other:
        return 'Connected to Other Network';
      default:
        return 'No Internet Connection';
    }
  }

  static bool isConnectionError(dynamic error) {
    if (error is SocketException) {
      return true;
    }
    if (error.toString().toLowerCase().contains('connection') ||
        error.toString().toLowerCase().contains('network') ||
        error.toString().toLowerCase().contains('timeout')) {
      return true;
    }
    return false;
  }
}
