import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plant_iot_epitech/models/wifi_detail.dart';
import 'package:plant_iot_epitech/services/api_url.dart';

enum GetWifiStatus {
  notFetched,
  fetching,
  fetched,
}

enum ConnectWifiStatus {
  notConnected,
  connecting,
  connected,
}

class WifiDetailOutput {
  final bool status;
  final bool? isConnected;
  final String? error;
  final String? message;
  List<WifiDetail>? wifis = [];

  WifiDetailOutput({
    required this.status,
    this.isConnected,
    this.error,
    this.message,
    this.wifis,
  });
}

class WifiDetailProvider with ChangeNotifier {
  GetWifiStatus _getWifiStatus = GetWifiStatus.notFetched;
  ConnectWifiStatus _connectWifiStatus = ConnectWifiStatus.notConnected;

  GetWifiStatus get getWifiStatus => _getWifiStatus;
  ConnectWifiStatus get connectWifiStatus => _connectWifiStatus;

  Future<WifiDetailOutput> connectWifi(
      String ssid, String serialNumber, String password) async {
    _connectWifiStatus = ConnectWifiStatus.connecting;
    notifyListeners();

    Map<String, dynamic> connectWifiData = {
      'ssid': ssid,
      'serialNumber': serialNumber,
      'password': password,
    };

    Response response = await post(
      Uri.parse(ApiURL.networkConnect),
      body: json.encode(connectWifiData),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    print(response.body);

    Map<String, dynamic> responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      _connectWifiStatus = ConnectWifiStatus.connected;
      notifyListeners();
      return WifiDetailOutput(
        status: true,
        isConnected: responseData['message'],
      );
    }

    _connectWifiStatus = ConnectWifiStatus.notConnected;
    notifyListeners();
    return WifiDetailOutput(
      status: false,
      error: responseData['error'],
      message: responseData['message'],
    );
  }

  Future<WifiDetailOutput> getWifi() async {
    _getWifiStatus = GetWifiStatus.fetching;

    Response response = await get(
      Uri.parse(ApiURL.networkScan),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    print(response.body);
    List<WifiDetail> wifis = wifiDetailFromJson(response.body);

    if (response.statusCode == 200) {
      _getWifiStatus = GetWifiStatus.fetched;
      notifyListeners();
      return WifiDetailOutput(
        status: true,
        wifis: wifis,
      );
    }

    Map<String, dynamic> responseData = json.decode(response.body);
    _getWifiStatus = GetWifiStatus.notFetched;
    notifyListeners();
    return WifiDetailOutput(
      status: false,
      error: responseData['error'],
      message: responseData['message'],
    );
  }
}
