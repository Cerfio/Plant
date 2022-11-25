/*
 * Make the builtin LED blink, but only when it's dark. Publish light or dark condition to a
 * MQTT topic.
 *
 * Connect an analog light sensor with the Arduino: GND to GND,
 * VCC to VCC, SIG to A1.
 *
 * Copyright (C) 2018 Andreas Motzek andreas-motzek@t-online.de
 *
 * You can use, redistribute and/or modify this file under the terms of the Modified Artistic License.
 * See http://simplysomethings.de/open+source/modified+artistic+license.html for details.
 *
 * This file is distributed in the hope that it will be useful, but without any warranty; without even
 * the implied warranty of merchantability or fitness for a particular purpose.
 */

#include <Client.h>
#include <WiFi101.h>
#include <CooperativeMultitasking.h>
#include <MQTTClient.h>

char ssid[] = "... WLAN SSID ...";
char pass[] = "... WLAN password ...";
char host[] = "... MQTT broker host name ...";
char clientid[] = "... MQTT client id ...";
char username[] = "... MQTT user name ...";
char password[] = "... MQTT password ...";
char topicname[] = "... MQTT topic name ....";

CooperativeMultitasking tasks;
Continuation beginWiFiIfNeeded;
Continuation connectMQTTClientIfNeeded;
Continuation light;
Continuation dark;
Guard isDark;
Continuation on;
Continuation off;
Guard isLight;

WiFiClient wificlient;
MQTTClient mqttclient(&tasks, &wificlient, host, 1883, clientid, username, password);
MQTTTopic topic(&mqttclient, topicname);

void setup() {
  Serial.begin(9600);
  //
  while (!Serial) {
    delay(1000);
  }
  //
  Serial.println("begin wifi");
  //
  WiFi.begin(ssid, pass);
  tasks.after(10000, beginWiFiIfNeeded); // after 10 seconds call beginWiFiIfNeeded()
  //
  Serial.println("connect mqtt client");
  //
  mqttclient.connect();
  tasks.after(15000, connectMQTTClientIfNeeded); // after 15 seconds call connectMQTTClientIfNeeded()
  //
  pinMode(LED_BUILTIN, OUTPUT);
  tasks.now(light); // call light() now
}

void loop() {
  tasks.run();
}

void light() {
  topic.publish("\"light\"");
  //
  tasks.ifForThen(isDark, 5000, dark); // if isDark() for 5 seconds then call dark()
}

void dark() {
  topic.publish("\"dark\"");
  //
  tasks.now(on); // call on() now
}

bool isDark() {
  return analogRead(A1) < 300;
}

void on() {
  digitalWrite(LED_BUILTIN, HIGH);
  tasks.after(1000, off); // after 1 second call off()
}

void off() {
  digitalWrite(LED_BUILTIN, LOW);
  auto task1 = tasks.after(1000, on); // after 1 second call on()
  auto task2 = tasks.ifForThen(isLight, 0, light); // if isLight() then call light()
  tasks.onlyOneOf(task1, task2); // do either task1 or task2
}

bool isLight() {
  return analogRead(A1) >= 400;
}

void beginWiFiIfNeeded() {
  switch (WiFi.status()) {
    case WL_IDLE_STATUS:
    case WL_CONNECTED: tasks.after(30000, beginWiFiIfNeeded); return; // after 30 seconds call beginWiFiIfNeeded() again
    case WL_NO_SHIELD: Serial.println("no wifi shield"); return; // do not check again
    case WL_CONNECT_FAILED: Serial.println("wifi connect failed"); break;
    case WL_CONNECTION_LOST: Serial.println("wifi connection lost"); break;
    case WL_DISCONNECTED: Serial.println("wifi disconnected"); break;
  }
  //
  WiFi.begin(ssid, pass);
  tasks.after(10000, beginWiFiIfNeeded); // after 10 seconds call beginWiFiIfNeeded() again
}

void connectMQTTClientIfNeeded() {
  if (!mqttclient.connected()) {
    Serial.println("mqtt client not connected");
    //
    mqttclient.connect();
  }
  //
  tasks.after(30000, connectMQTTClientIfNeeded); // after 30 seconds call connectMQTTClientIfNeeded() again
}
