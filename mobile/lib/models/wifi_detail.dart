// To parse this JSON data, do
//
//     final wifiDetail = wifiDetailFromJson(jsonString);

import 'dart:convert';

List<WifiDetail> wifiDetailFromJson(String str) =>
    List<WifiDetail>.from(json.decode(str).map((x) => WifiDetail.fromJson(x)));

String wifiDetailToJson(List<WifiDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WifiDetail {
  WifiDetail({
    required this.ssid,
    required this.rssi,
    required this.hasEncryption,
  });

  String ssid;
  int rssi;
  bool hasEncryption;

  factory WifiDetail.fromJson(Map<String, dynamic> json) => WifiDetail(
        ssid: json["ssid"],
        rssi: json["rssi"],
        hasEncryption: json["has_encryption"],
      );

  Map<String, dynamic> toJson() => {
        "ssid": ssid,
        "rssi": rssi,
        "has_encryption": hasEncryption,
      };
}
