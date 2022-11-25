import fp from 'fastify-plugin';

// Inputs
import { userUpdateBodySchema } from './dtos/input/user.update.input';
import { userUpdatePasswordBodySchema } from './dtos/input/user.updatePassword.input';

// Outputs
import { userUpdateResponseSchema } from './dtos/output/user.update.output';
import { userUpdatePasswordResponseSchema } from './dtos/output/user.updatePassword.output';
import { UserController } from './user.controller';

export default fp(async (server: any, opts: any, next: any) => {
  server.put(
    '/user',
    {
      preValidation: [server.sentry, server.authenticate],
      schema: {
        body: userUpdateBodySchema,
        response: userUpdateResponseSchema,
      },
    },
    new UserController(server).update,
  );
  next();
});
