import { LogTaskController } from '../../common/LogTask';
import { WebPushSubscriptionService } from './webPushSubscription.service';

export class WebPushSubscriptionController {
  logTask: LogTaskController = new LogTaskController('WebPushSubscriptionController');
  webPushSubscriptionService: WebPushSubscriptionService = new WebPushSubscriptionService(this.server);
  constructor(readonly server: any) {}

  create = async (request: any, reply: any) => {
    this.logTask.start('create');
    const {
      endpoint,
      keys: { p256dh, auth },
      expirationTime,
    } = request.body;

    await this.webPushSubscriptionService.create(endpoint, expirationTime, p256dh, auth, request.user.id);

    this.logTask.end('create');
    reply.code(200).send({ message: true });
  };
}
