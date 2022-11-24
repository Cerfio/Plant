//#include <Wire.h>
//#include <Adafruit_Sensor.h>
#include <Adafruit_BME280.h>

// Constantes du programme
#define adresseI2CduBME280 0x76
#define pressionAuNiveauDeLaMerEnHpa 1024.90
#define delaiRafraichissementAffichage 1500

Adafruit_BME280 bme;

void setup() {
  Serial.begin(9600);

  // Initialisation du BME280
  Serial.print(F("Initialisation du BME280, à l'adresse [0x"));
  Serial.print(adresseI2CduBME280, HEX);
  Serial.println(F("]"));

  if (!bme.begin(adresseI2CduBME280)) {
    Serial.println(F("--> ÉCHEC…"));
  } else {
    Serial.println(F("--> RÉUSSIE !"));
  }
  Serial.println();
}

const int get_light_luminosity() {
  const int value = analogRead(A0);
  const int compute_percentage = (100 - ((value / 1023.00) * 100));
  return compute_percentage;
}

const int get_soil_moisture() {
  const int value = analogRead(A1);
  const int compute_percentage = (100 - ((value / 1023.00) * 100));
  return compute_percentage;
}

struct bme_sensor {
  int temperature;
  int humidity;
  int pression;
  int altitude;
};

struct bme_sensor get_temperature_humidity_pression_altitude() {
  bme_sensor local_bme_sensor;

  local_bme_sensor.temperature = bme.readTemperature() - 1;
  local_bme_sensor.humidity = bme.readHumidity();
  local_bme_sensor.pression = bme.readPressure() / 100.0F;
  local_bme_sensor.altitude = bme.readAltitude(pressionAuNiveauDeLaMerEnHpa);
  return local_bme_sensor;
}

void loop() {
  // const int light_value = get_light_luminosity();
  // Serial.print("Light luminosity value : ");
  // Serial.println(light_value);
  const bme_sensor bme_sensor = get_temperature_humidity_pression_altitude();
  // const int soil_moisture_value = get_soil_moisture();
  // Serial.print("Soil moisture value : ");
  // Serial.println(soil_moisture_value);

  delay(1000);
}