#include <ESP8266WiFi.h>
#include <ESP8266Ping.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <ArduinoJson.h>
#include <Preferences.h>
#include <CooperativeMultitasking.h>
#include <MQTTClient.h>
#include <SPI.h>

#ifndef APSSID
#define HOSTNAME "Plant"
#define NUMBER_MAX_TRY_CONNECTION 3
#define SERVER_PING "www.google.com"
#define PREFERENCE_FILE_NAME "wificreds"
#define HOSTNAME_MQTT "192.168.1.30"
#define HOST_IP_MQTT 1883
#define TOPIC_MQTT "/plant/data"
#endif

char clientid[] = "Cerfio-Arduino";
char topicname[] = TOPIC_MQTT;


ESP8266WebServer server(80);

Preferences preferences;

CooperativeMultitasking tasks;
WiFiClient wificlient;
MQTTClient mqttclient(&tasks, &wificlient, HOSTNAME_MQTT, HOST_IP_MQTT, clientid, NULL, NULL);
MQTTTopic topic(&mqttclient, topicname);

bool canPublish = false;

void scanNetwork() {
  //WiFi.mode(WIFI_STA);
  //WiFi.disconnect();
  DynamicJsonDocument doc(2048);


  int n = WiFi.scanNetworks();

  for (int i = 0; i < n; ++i) {
    doc[i]["ssid"] = WiFi.SSID(i);
    doc[i]["rssi"] = WiFi.RSSI(i);
    doc[i]["has_encryption"] = WiFi.encryptionType(i) == ENC_TYPE_NONE ? false : true;
  }
  String output;
  serializeJson(doc, output);

  server.send(200, "text/json", output);
}

bool connectWifi(const char* ssid, const char* password) {
  WiFi.hostname(HOSTNAME);

  int max_connection_try = 0;
  int status = WL_IDLE_STATUS;

  while (status != WL_CONNECTED && max_connection_try < NUMBER_MAX_TRY_CONNECTION) {
    Serial.print("Attempting to connect to SSID: ");
    WiFi.begin(ssid, password);

    // wait 5 seconds for try a new connection:
    delay(5000);
    status = WiFi.status();
    Serial.println(status);
    max_connection_try++;
  }
  if (status != WL_CONNECTED) {
    Serial.println("Fail connection");
    return false;
  }
  bool hasPing = Ping.ping(SERVER_PING);
  if (!hasPing) {
    Serial.println("Fail ping");
    return false;
  }
  return true;
}

bool connectMqtt() {

  int max_connection_try = 0;
  bool status = false;

  while (status != true && max_connection_try < NUMBER_MAX_TRY_CONNECTION) {
    Serial.println("Attempting to connect to MQTT");
    status = mqttclient.connect();
    delay(1000);
    max_connection_try++;
  }
  if (status == false) {
    Serial.println("Fail MQTT connection");
    return false;
  }
  return true;
}

void connectNetwork() {
  if (server.hasArg("plain") == false) {  //Check if body received

    server.send(200, "text/plain", "Body not received");
    return;
  }
  DynamicJsonDocument doc(1024);
  deserializeJson(doc, server.arg("plain"));
  const char* ssid = doc["ssid"];
  const char* password = doc["password"];
  const char* serialNumber = doc["serialNumber"];

  if (ssid == NULL) {
    server.send(400, "text/json", "{\"message\":\"Missing ssid\"}");
  }
  if (password == NULL) {
    server.send(400, "text/json", "{\"message\":\"Missing password\"}");
  }
  if (serialNumber == NULL) {
    server.send(400, "text/json", "{\"message\":\"Missing serial number\"}");
  }
  bool isConnected = connectWifi(ssid, password);
  if (!isConnected) {
    server.send(400, "text/json", "{\"message\":false}");
    return;
  }

  /* Write credentials in storage cache */
  preferences.begin("credentials", false);
  preferences.putString("ssid", ssid);
  preferences.putString("password", password);
  preferences.putString("serialNumber", serialNumber);


  server.send(200, "text/json", "{\"message\":true}");
}

void setup() {
  delay(1000);
  Serial.begin(9600);

  Serial.println();
  Serial.println("Configuring access point...");


  preferences.begin(PREFERENCE_FILE_NAME);

  String ssid = preferences.getString("ssid", "");
  String password = preferences.getString("password", "");

  Serial.println("_____credentials cache_____");
  Serial.println(ssid);
  Serial.println(password);
  Serial.println("_____credentials cache_____");
  bool run_server = true;
  if (ssid != "" || password != "") {
    bool isConnected = connectWifi(ssid.c_str(), password.c_str());
    if (isConnected) {
      run_server = false;
      Serial.println("Already have wifi");
    }
    if (isConnected) {
      canPublish = connectMqtt();
    }
  }

  if (run_server) {
    WiFi.mode(WIFI_AP_STA);
    WiFi.softAP(HOSTNAME);

    server.on("/network/scan", scanNetwork);
    server.on("/network/connect", connectNetwork);
    server.begin();
    Serial.println("HTTP server started");
  }
  mqttclient.connect();
}

void loop() {
  if (canPublish) {
    topic.publish("{\"serialNumber\":\"1234567890\",\"temperature\":25,\"humiditySoil\":50,\"humidityAir\":50,\"light\":50,\"battery\":3.7,\"pressure\":1000}", false);
    while (tasks.available()) {
      tasks.run();
    }
  }


  // Dont overload the server!
  delay(1000);
}