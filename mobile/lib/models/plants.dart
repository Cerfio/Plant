// To parse this JSON data, do
//
//     final plant = plantFromJson(jsonString);

import 'dart:convert';

List<Plant> plantFromJson(String str) =>
    List<Plant>.from(json.decode(str).map((x) => Plant.fromJson(x)));

String plantToJson(List<Plant> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Plant {
  Plant({
    required this.id,
    required this.name,
    required this.serialNumber,
    required this.macAddress,
    required this.datas,
  });

  String id;
  String name;
  String serialNumber;
  String macAddress;
  List<PlantData> datas;

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        id: json["id"],
        name: json["name"],
        serialNumber: json["serialNumber"],
        macAddress: json["macAddress"],
        datas: List<PlantData>.from(
          json["datas"].map(
            (x) => PlantData.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "serialNumber": serialNumber,
        "macAddress": macAddress,
        "datas": List<dynamic>.from(
          datas.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class PlantData {
  PlantData({
    required this.temperature,
    required this.humidityAir,
    required this.humiditySoil,
    required this.pressure,
    required this.battery,
    required this.light,
  });

  int temperature;
  int humidityAir;
  int humiditySoil;
  int pressure;
  int battery;
  int light;

  factory PlantData.fromJson(Map<String, dynamic> json) => PlantData(
        temperature: json["temperature"],
        humidityAir: json["humidityAir"],
        humiditySoil: json["humiditySoil"],
        pressure: json["pressure"],
        battery: json["battery"],
        light: json["light"],
      );

  Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "humidityAir": humidityAir,
        "humiditySoil": humiditySoil,
        "pressure": pressure,
        "battery": battery,
        "light": light,
      };
}
