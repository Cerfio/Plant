import fp from 'fastify-plugin';
import { WebPushSubscriptionController } from './webPushSubscription.controller';

export default fp(async (server: any, opts: any, next: any) => {
  server.post(
    '/web/push/subscription',
    {
      preValidation: [server.sentry, server.authenticate],
    },
    new WebPushSubscriptionController(server).create,
  );
  next();
});
