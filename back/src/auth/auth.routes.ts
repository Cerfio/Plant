import fp from 'fastify-plugin';
import { signInBodySchema } from './dtos/auth.signin.input';
import { signUpBodySchema } from './dtos/auth.signup.input';
import { signInResponseSchema } from './dtos/auth.signin.output';
import { signUpResponseSchema } from './dtos/auth.signup.output';
import { AuthController } from './auth.controller';
import { emailAvailableQuerySchema } from './dtos/auth.emailAvailable.input';
import { authGoogleBodySchema } from './dtos/auth.google.input';
import { authGoogleResponseSchema } from './dtos/auth.google.output';

export default fp(async (server: any, opts: any, next: any) => {
  server.post(
    '/auth/signin',
    {
      preValidation: [server.sentry],
      schema: {
        body: signInBodySchema,
        response: signInResponseSchema,
      },
    },
    new AuthController(server).signIn,
  );

  server.post(
    '/auth/signup',
    {
      schema: {
        body: signUpBodySchema,
        response: signUpResponseSchema,
      },
    },
    new AuthController(server).signUp,
  );

  server.get(
    '/auth/email/available',
    {
      schema: {
        querystring: emailAvailableQuerySchema,
      },
    },
    new AuthController(server).emailAvailable,
  );

  next();
});
