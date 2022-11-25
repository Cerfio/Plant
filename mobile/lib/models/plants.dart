// To parse this JSON data, do
//
//     final plants = plantsFromJson(jsonString);

import 'dart:convert';

List<Plants> plantsFromJson(String str) => List<Plants>.from(json.decode(str).map((x) => Plants.fromJson(x)));

String plantsToJson(List<Plants> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Plants {
    Plants({
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
    List<Data> datas;

    factory Plants.fromJson(Map<String, dynamic> json) => Plants(
        id: json["id"],
        name: json["name"],
        serialNumber: json["serialNumber"],
        macAddress: json["macAddress"],
        datas: List<Data>.from(json["datas"].map((x) => Data.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "serialNumber": serialNumber,
        "macAddress": macAddress,
        "datas": List<dynamic>.from(datas.map((x) => x.toJson())),
    };
}

class Data {
    Data({
      required this.temperature,
      required this.humidityAir,
      required this.humiditySoil,
      required this.pressure,
      required this.battery,
      required this.light,
      required this.water,
    });

    int temperature;
    int humidityAir;
    int humiditySoil;
    int pressure;
    int battery;
    int light;
    int water;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        temperature: json["temperature"],
        humidityAir: json["humidityAir"],
        humiditySoil: json["humiditySoil"],
        pressure: json["pressure"],
        battery: json["battery"],
        light: json["light"],
        water: json["water"],
    );

    Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "humidityAir": humidityAir,
        "humiditySoil": humiditySoil,
        "pressure": pressure,
        "battery": battery,
        "light": light,
        "water": water,
    };
}
