import fp from 'fastify-plugin';
import { plantCreateBodySchema } from './dtos/input/plant.create.input';
import { plantDeleteParamSchema } from './dtos/input/plant.delete.input';
import { plantCreateResponseSchema } from './dtos/output/plant.create.output';
import { plantDeleteResponseSchema } from './dtos/output/plant.delete.output';
import { plantGetsResponseSchema } from './dtos/output/plant.gets.output';
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
  )

  server.get(
    '/plant',
    {
      preValidation: [server.sentry, server.authenticate],
      schema: {
        response: plantGetsResponseSchema,
      },
    },
    new PlantController(server).gets,
  );

  /*
  server.get(
    '/plant/:id',
    {
      preValidation: [server.sentry],
      schema: {
        body: userUpdatePasswordBodySchema,
        response: userUpdatePasswordResponseSchema,
      },
    },
    new UserController(server).updatePassword,
  );
  */
  next();
});
