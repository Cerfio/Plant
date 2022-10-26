
const mqtt = require("mqtt");
const brokerURI = "mqtt://192.168.1.30";

const client = mqtt.connect(brokerURI, {
  port: 1883,
  // username: "plant-iot",
  // password: "58@3nv#G22zRy57dVE7&xt",
});

const topic = "/nodejs/mqtt";
client.on("connect", () => {
  console.log("Connected");
  client.subscribe([topic], () => {
    console.log(`Subscribe to topic '${topic}'`);
  });
});

client.on("message", (topic, payload) => {
  console.log("Received Message:", topic, payload.toString());
});
