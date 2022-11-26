/* eslint-disable no-console */
import * as config from './../config/config';
import fastify from 'fastify';
import fastifyBlipp from 'fastify-blipp';
import fastifyJwt from '@fastify/jwt';
import fastifyCors from '@fastify/cors';
import mqtt from 'mqtt';

import fastifySensible from '@fastify/sensible';
import fastifyEnv from '@fastify/env';

// decorates
import jwtDecorate from './decorates/jwt.decorate';
import sentryDecorate from './decorates/sentry.decorate';

// routes
import authRoutes from './auth/auth.routes';
import plantRoutes from './plant/plant.routes';
import userRoutes from './user/user.routes';

import { PlantDataController } from './plantData/plantData.controller';

const server: any = fastify({ logger: true });

const loadPlugins = async () => {
  await server.register(fastifyEnv, config.options);
  await server.register(fastifyBlipp);
  await server.register(fastifySensible);
  await server.register(fastifyJwt, {
    secret: server.config.SECRET_JWT,
    sign: { algorithm: 'HS256', expiresIn: '31d' },
  });
  await server.register(fastifyCors, {
    origin: '*',
  });
};

const loadDecorates = async () => {
  await server.register(jwtDecorate).register(sentryDecorate);
};

const loadRoutes = async () => {
  await server.register(authRoutes).register(plantRoutes).register(userRoutes);
};

const start = async () => {
  try {
    await loadDecorates();
    await loadPlugins();
    await loadRoutes();

    server.sockets = [];
    await server.ready();
    server.blipp();
    const client = mqtt.connect('mqtt://192.168.1.30', {
      port: server.config.MQTT_PORT,
      // username: "plant-iot",
      // password: "58@3nv#G22zRy57dVE7&xt",
    });
    const topic = '/plant/data';
    client.on('connect', () => {
      console.log('Connected');
      client.subscribe([topic], () => {
        console.log(`Subscribe to topic '${topic}'`);
      });
    });

    client.on('message', (topic, payload) => {
      const data: {
        serialNumber: string;
        temperature: number;
        humiditySoil: number;
        humidityAir: number;
        light: number;
        battery: number;
        pressure: number;
      } = JSON.parse(payload.toString());

      // create plant data
      const plantDataController = new PlantDataController(server);
      plantDataController.create(
        data.serialNumber,
        data.temperature,
        data.humiditySoil,
        data.humidityAir,
        data.light,
        data.battery,
        data.pressure,
      );
    });

    server.listen({ port: server.config.PORT, host: '0.0.0.0' });
  } catch (err) {
    server.log.error(err);
    process.exit(1);
  }
};

start();
