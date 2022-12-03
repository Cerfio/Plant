import fp from 'fastify-plugin';
import { plantCreateBodySchema } from './dtos/input/plant.create.input';
import { plantDeleteParamSchema } from './dtos/input/plant.delete.input';
import { plantGetParamSchema } from './dtos/input/plant.get.input';

import { plantCreateResponseSchema } from './dtos/output/plant.create.output';
import { plantDeleteResponseSchema } from './dtos/output/plant.delete.output';
import { plantGetsResponseSchema } from './dtos/output/plant.gets.output';
import { plantGetResponseSchema } from './dtos/output/plant.get.output';

import { PlantController } from './plant.controller';

// Inputs

// Outputs

export default fp(async (server: any, opts: any, next: any) => {
  server.post(
    '/plant',
    {
      preValidation: [server.sentry, server.authenticate],
      schema: {
        body: plantCreateBodySchema,
        response: plantCreateResponseSchema,
      },
    },
    new PlantController(server).create,
  );

  server.get(
    '/plant/:id',
    {
      preValidation: [server.sentry, server.authenticate],
      exposeHeadRoute: false,
      schema: {
        params: plantGetParamSchema,
        response: plantGetResponseSchema,
      },
    },
    new PlantController(server).get,
  );

  server.delete(
    '/plant/:id',
    {
      preValidation: [server.sentry, server.authenticate],
      schema: {
        params: plantDeleteParamSchema,
        response: plantDeleteResponseSchema,
      },
    },
    new PlantController(server).delete,
  );

  server.get(
    '/plant',
    {
      preValidation: [server.sentry, server.authenticate],
      exposeHeadRoute: false,
      schema: {
        response: plantGetsResponseSchema,
      },
    },
    new PlantController(server).gets,
  );

  server.get(
    '/user/plant',
    {
      preValidation: [server.sentry, server.authenticate],
      exposeHeadRoute: false,
    },
    new PlantController(server).plantsUser,
  );
  next();
});
