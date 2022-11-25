## MQTT Client

MQTT Client is a library that can publish strings to a topic of a MQTT broker.
For using it you have to include the library
[Cooperative Multitasking](https://bitbucket.org/amotzek/cooperative-multitasking) too.

#### Example

The following example publishes the string `"Hello"` to the topic `"amotzek/hello"`
of the broker broker.hivemq.com repeatedly. The message can be observed in HiveMQs
[Websockets client](http://www.hivemq.com/demos/websocket-client/).

The example assumes that you connect to the internet via `Wifi101`, so you need the
SSID and the password of your WLAN. You also need an Arduino board that is compatible
with `Wifi101`, e.g. the MKR1000. If your board connects to the internet in a
different way, you have to pass a different client (for example an `EthernetClient`)
to the constructor of `MQTTClient`.

    #include <Client.h>
    #include <WiFi101.h>
    #include <CooperativeMultitasking.h>
    #include <MQTTClient.h>

    char ssid[] = "...";
    char pass[] = "...";
    char host[] = "broker.hivemq.com";
    char clientid[] = "...";
    char username[] = "...";
    char password[] = "...";
    char topicname[] = "amotzek/hello";

    CooperativeMultitasking tasks;
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
      WiFi.begin(ssid, pass);
      delay(10000); // wait until WiFi connection is established
    }

    void loop() {
      if (mqttclient.connect()) {
        topic.publish("Hello");
        //
        while (tasks.available()) {
          tasks.run(); // receive connect acknowledgement, send publish, receive publish acknowledgement
        }
        //
        mqttclient.disconnect();
      }
      //
      switch (WiFi.status()) {
        case WL_CONNECT_FAILED:
        case WL_CONNECTION_LOST:
        case WL_DISCONNECTED: WiFi.begin(ssid, pass); // reconnect WiFi if necessary
      }
      //
      delay(30000);
    }

#### Details

To create an instance of class `MQTTClient` you need a reference to an instance of class
`CooperativeMultitasking`, a reference to an instance of a network connection (e.g. from
`WiFi101` or `Ethernet`), the host name of the MQTT broker, its port number (typically
1883) and a client id. If the broker requires that, you also have to pass a user name and
a password.

To create an instance of class `MQTTTopic` you have to pass a reference to an instance of
`MQTTClient` and the topic name.

The method `connect()` of `MQTTClient` creates a network connection to the broker.

You can publish a string by calling the method `publish("...")` of `MQTTTopic`. The
method can be called independently of an established connection to the MQTT broker. It
will delay publishing your message until a connection becomes available.

The message is published with QoS 1. That means that `MQTTClient` waits for a publish
acknowledgement from the MQTT broker. If the acknowledgement does not arrive in time,
`MQTTClient` retries publishing the message up to 15 times until it gives up.

`connect` and `publish` work asynchronously. They create tasks that are managed by the
instance of `CooperativeMultitasking`. That's why you have to call it's method `run()`
until all tasks are finished.
