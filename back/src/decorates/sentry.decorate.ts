import fp from 'fastify-plugin';
import * as Sentry from '@sentry/node';

export default fp(async (server: any) => {
  server.decorate('sentry', async (request: any) => {
    Sentry.init({
      dsn: server.config.SENTRY_DNS,
      tracesSampleRate: 1.0,
    });
    const transactionId = request.headers['x-transaction-id'];
    Sentry.configureScope(scope => {
      scope.setTag('transaction_id', transactionId);
    });
  });
});
