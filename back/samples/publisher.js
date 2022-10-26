require('dotenv').config()
const mqtt = require("mqtt"); // https://github.com/mqttjs/MQTT.js

const brokerURI = "nmq-tcp://0.0.0.0:1883";

// create client and connect
const client = mqtt.connect(brokerURI, {
    clientId: "cerfio",
});
const topic = "/nodejs/mqtt";
client.on("connect", () => {
    // console.log("Connected");
  client.publish(
    topic,
    "nodejs mqtt test",
    { qos: 0, retain: false },
    (error) => {
      if (error) {
        console.error(error);
      }
    }
  );
});
