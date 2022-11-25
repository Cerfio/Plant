/*
 * Publishes "Hello" at regular intervals. The message can be subscribed and observed in HiveMQs
 * Websockets client http://www.hivemq.com/demos/websocket-client/
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
  delay(10000);
}

void loop() {
  if (mqttclient.connect()) {
    topic.publish("Hello");
    //
    while (tasks.available()) {
      tasks.run();
    }
    //
    mqttclient.disconnect();
  }
  //
  switch (WiFi.status()) {
    case WL_CONNECT_FAILED:
    case WL_CONNECTION_LOST:
    case WL_DISCONNECTED: WiFi.begin(ssid, pass);
  }
  //
  delay(30000);
}
