import fp from 'fastify-plugin';
import { NotificationController } from './notification.controller';
import { notificationGetsResponseSchema } from './dtos/output/notification.gets.output';

export default fp(async (server: any, opts: any, next: any) => {
  server.get(
    '/test/notification/:userId',
    {
      exposeHeadRoute: false,
      schema: {
        params: {
          type: 'object',
          required: ['userId'],
          properties: {
            userId: { type: 'string', format: 'uuid' },
          },
        },
      },
    },
    new NotificationController(server).test,
  );

  server.get(
    '/notifications',
    {
      preValidation: [server.sentry, server.authenticate],
      exposeHeadRoute: false,
    },
    new NotificationController(server).gets,
  );

  next();
});
