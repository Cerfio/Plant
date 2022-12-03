import { LogTaskController } from '../../common/LogTask';
import webpush from 'web-push';
import { WebPushSubscriptionService } from '../webPushSubscription/webPushSubscription.service';

export class NotificationController {
  logTask: LogTaskController = new LogTaskController('NotificationController');
  webPushSubscriptionService: WebPushSubscriptionService = new WebPushSubscriptionService(this.server);
  constructor(readonly server: any) {}

  test = async (request: any, reply: any) => {
    this.logTask.start('test');
    const { userId } = request.params;

    const subscriptions = await this.webPushSubscriptionService.findMany(userId);

    for (const subscription of subscriptions) {
      try {
        await webpush.sendNotification(
          {
            endpoint: subscription.endpoint,
            keys: {
              p256dh: subscription.p256dh,
              auth: subscription.auth,
            },
          },
          'dataToSend',
        );
      } catch (e: any) {
        this.webPushSubscriptionService.delete(subscription.id);
      }
    }
    this.logTask.end('test');
    reply.code(200).send({ message: true });
  };
}
