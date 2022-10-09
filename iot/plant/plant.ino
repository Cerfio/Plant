#include <ESP8266WiFi.h>
#include <ESP8266Ping.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>
#include <ArduinoJson.h>
#include <Preferences.h>

#include <SPI.h>

#ifndef APSSID
#define HOSTNAME "Plant"
#define NUMBER_MAX_TRY_CONNECTION 3
#define SERVER_PING "www.google.com"
#define PREFERENCE_FILE_NAME "wificreds"
#endif

ESP8266WebServer server(80);

Preferences preferences;

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

  Serial.print("Input ssid: ");
  Serial.println(ssid);
  Serial.print("Input password: ");
  Serial.println(password);

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

void connectNetwork() {
  if (server.hasArg("plain") == false) {  //Check if body received

    server.send(200, "text/plain", "Body not received");
    return;
  }
  DynamicJsonDocument doc(1024);
  deserializeJson(doc, server.arg("plain"));
  const char* ssid = doc["ssid"];
  const char* password = doc["password"];

  if (ssid == NULL) {
    server.send(200, "text/json", "{\"message\":\"Missing ssid\"}");
  }
  if (password == NULL) {
    server.send(200, "text/json", "{\"message\":\"Missing password\"}");
  }
  bool isConnected = connectWifi(ssid, password);
  if (!isConnected) {
    server.send(200, "text/json", "{\"message\":false}");
    return;
  }

  /* Write credentials in storage cache */
  preferences.begin("credentials", false);
  preferences.putString("ssid", ssid);
  preferences.putString("password", password);


  server.send(200, "text/json", "{\"message\":true}");
}


void setup() {
  delay(1000);
  Serial.begin(115200);

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
  }

  if (run_server) {
    WiFi.mode(WIFI_AP_STA);
    WiFi.softAP(HOSTNAME);

    server.on("/network/scan", scanNetwork);
    server.on("/network/connect", connectNetwork);
    server.begin();
    Serial.println("HTTP server started");
  }
}

void loop() {
  server.handleClient();
}