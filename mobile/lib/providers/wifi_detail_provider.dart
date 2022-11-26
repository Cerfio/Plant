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

class WifiDetailOutput {
  final bool status;
  final String? error;
  final String? message;
  List<WifiDetail>? wifis = [];

  WifiDetailOutput({
    required this.status,
    this.error,
    this.message,
    this.wifis,
  });
}

class WifiDetailProvider with ChangeNotifier {
  GetWifiStatus _getWifiStatus = GetWifiStatus.notFetched;

  GetWifiStatus get getWifiStatus => _getWifiStatus;

  Future<WifiDetailOutput> getWifi() async {
    _getWifiStatus = GetWifiStatus.fetching;
    notifyListeners();

    Response response = await get(
      Uri.parse(ApiURL.networkScan),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

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
