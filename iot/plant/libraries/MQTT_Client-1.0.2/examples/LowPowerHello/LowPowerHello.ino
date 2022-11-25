/*
 * Publishes "Hello" at regular intervals. The message can be subscribed and observed in HiveMQs
 * Websockets client http://www.hivemq.com/demos/websocket-client/
 *
 * If the libraries Arduino Low Power and RTC Zero are included then Cooperative Multitasking
 * uses LowPower.idle(...) instead of delay(...).
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
#include <ArduinoLowPower.h>
#include <CooperativeMultitasking.h>
#include <MQTTClient.h>

char ssid[] = "...";
char pass[] = "...";
char host[] = "broker.hivemq.com";
char clientid[] = " ";
char topicname[] = "amotzek/hello";

CooperativeMultitasking tasks;
WiFiClient wificlient;
MQTTClient mqttclient(&tasks, &wificlient, host, 1883, clientid, NULL, NULL);
MQTTTopic topic(&mqttclient, topicname);

void setup() {
  Serial.begin(9600);
  //
  while (!Serial) {
    delay(1000);
  }
  //
  WiFi.begin(ssid, pass);
  tasks.after(10000, checkWiFi); // after 10 seconds call checkWiFi()
  tasks.after(10000, checkBroker); // after 10 seconds call checkBroker()
  tasks.after(30000, publishHello); // after 30 seconds call publishHello()
}

void loop() {
  tasks.run();
}

void checkWiFi() {
  switch (WiFi.status()) {
    case WL_CONNECT_FAILED:
    case WL_CONNECTION_LOST:
    case WL_DISCONNECTED:
      Serial.println("wifi not connected");
      WiFi.begin(ssid, pass);
      tasks.after(10000, checkWiFi); // after 10 seconds call checkWiFi()
      //
      return;
  }
  //
  tasks.after(30000, checkWiFi); // after 30 seconds call checkWiFi()
}

void checkBroker() {
  if (!mqttclient.connected()) {
    Serial.println("mqtt client not connected");
    mqttclient.connect();
  }
  //
  tasks.after(30000, checkBroker); // after 30 seconds call checkBroker()
}

void publishHello() {
  if (mqttclient.connected()) topic.publish("Hello");
  //
  tasks.after(30000, publishHello); // after 30 seconds call publishHello()
}
