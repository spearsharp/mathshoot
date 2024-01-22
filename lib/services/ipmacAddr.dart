import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  final String ipAddress;
  final String macAddress;

  NetworkInfo({required this.ipAddress, required this.macAddress});

  factory NetworkInfo.fromJson(Map<String, dynamic> json) {
    return NetworkInfo(
      ipAddress: json['ipAddress'] as String,
      macAddress: json['macAddress'] as String,
    );
  }
}

class NetworkService {
  final String? ipAddress;
  final String? macAddress;

  NetworkService({this.ipAddress, this.macAddress});

  Future<NetworkInfo> getNetworkInfo() async {
    String ipAddress = await getIpAddress();
    String macAddress = await getMacAddress();
    return NetworkInfo(ipAddress: ipAddress, macAddress: macAddress);
  }

  Future<String> getIpAddress() async {
    if (kIsWeb) return ''; // Web doesn't support this feature.
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) return '';
    if (result == ConnectivityResult.wifi) {
      return await getIpAddressWifi();
    } else if (result == ConnectivityResult.mobile) {
      return await getIpAddressMobile();
    } else {
      return ''; // Unsupported connectivity type.
    }
  }

  Future<String> getIpAddressWifi() async {
    // This is a placeholder, as there is no standard API to get the IP address of the device when connected to a wifi network.
    // You would typically need to rely on a third-party library or an external service to achieve this.
    return '';
  }

  Future<String> getIpAddressMobile() async {
    // This is a placeholder, as there is no standard API to get the IP address of the device when connected to a mobile network.
    // You would typically need to rely on a third-party library or an external service to achieve this.
    return '';
  }

  Future<String> getMacAddress() async {
    if (kIsWeb) return ''; // Web doesn't support this feature.
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) return '';
    if (result == ConnectivityResult.wifi) {
      return await getMacAddressWifi();
    } else if (result == ConnectivityResult.mobile) {
      return await getMacAddressMobile();
    } else {
      return ''; // Unsupported connectivity type.
    }
  }

  Future<String> getMacAddressWifi() async {
    // This is a placeholder, as there is no standard API to get the MAC address of the device when connected to a wifi network.
    // You would typically need to rely on a third-party library or an external service to achieve this.
    return '';
  }

  Future<String> getMacAddressMobile() async {
    // This is a placeholder, as there is no standard API to get the MAC address of the device when connected to a mobile network.
    // You would typically need to rely on a third-party library or an external service to achieve this.
    return '';
  }
}
