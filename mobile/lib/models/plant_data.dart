class PlantData {
  double temperature;
  double humidityAir;
  double humiditySoil;
  double pressure;
  double battery;
  double light;

  PlantData({
    required this.temperature,
    required this.humidityAir,
    required this.humiditySoil,
    required this.pressure,
    required this.battery,
    required this.light,
  });

  factory PlantData.fromJson(Map<String, dynamic> responseData) {
    return PlantData(
      temperature: responseData['temperature'],
      humidityAir: responseData['humidityAir'],
      humiditySoil: responseData['humiditySoil'],
      pressure: responseData['pressure'],
      battery: responseData['battery'],
      light: responseData['light'],
    );
  }
}
