/* eslint-disable no-console */
import * as config from "./../config/config";
import fastify from "fastify";
import fastifyBlipp from "fastify-blipp";
import fastifyJwt from "@fastify/jwt";

import fastifySensible from "@fastify/sensible";
import fastifyEnv from "@fastify/env";

// decorates
import jwtDecorate from "./decorates/jwt.decorate";
import sentryDecorate from "./decorates/sentry.decorate";

// routes
import authRoutes from "./auth/auth.routes";
import plantRoutes from "./plant/plant.routes";

const server: any = fastify({ logger: true });

const loadPlugins = async () => {
  await server.register(fastifyEnv, config.options);
  await server.register(fastifyBlipp);
  await server.register(fastifySensible);
  await server.register(fastifyJwt, {
    secret: server.config.SECRET_JWT,
    sign: { algorithm: "HS256", expiresIn: "31d" },
  });
};

const loadDecorates = async () => {
  await server.register(jwtDecorate).register(sentryDecorate);
};

const loadRoutes = async () => {
  await server.register(authRoutes).register(plantRoutes);
};

const start = async () => {
  try {
    await loadDecorates();
    await loadPlugins();
    await loadRoutes();

    server.sockets = [];
    await server.ready();
    server.blipp();
    server.listen({ port: server.config.PORT, host: "0.0.0.0" });
  } catch (err) {
    server.log.error(err);
    process.exit(1);
  }
};

start();
