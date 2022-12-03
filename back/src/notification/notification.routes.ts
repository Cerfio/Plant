import fp from 'fastify-plugin';
import { NotificationController } from './notification.controller';

export default fp(async (server: any, opts: any, next: any) => {
  server.get(
    '/test/notification/:userId',
    {
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
  next();
});
