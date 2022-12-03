import { LogTaskService } from '../../common/LogTask';
import { PrismaError } from '../prisma/prisma.exception';
import prisma from '../prisma/prisma.client';

export class WebPushSubscriptionService {
  logTask: LogTaskService = new LogTaskService('WebPushSubscriptionService');
  constructor(readonly server: any) {}

  create = async (endpoint: string, expirationTime: string | null, p256dh: string, auth: string, userId: string) => {
    this.logTask.start('create');

    try {
      await prisma.webPushSubscription.create({
        data: {
          auth,
          endpoint,
          expirationTime,
          p256dh,
          user: {
            connect: {
              id: userId,
            },
          },
        },
      });
      this.logTask.end('create');
    } catch (e: any) {
      throw new PrismaError(this.server, this.logTask, e, true);
    }
  };

  findMany = async (userId: string) => {
    this.logTask.start('findMany');

    try {
      const webPushSubscription = await prisma.webPushSubscription.findMany({
        where: {
          userId,
        },
      });
      this.logTask.end('findMany');
      return webPushSubscription;
    } catch (e: any) {
      throw new PrismaError(this.server, this.logTask, e, true);
    }
  };

  delete = async (id: string) => {
    this.logTask.start('delete');

    try {
      await prisma.webPushSubscription.delete({
        where: {
          id,
        },
      });
      this.logTask.end('delete');
    } catch (e: any) {
      throw new PrismaError(this.server, this.logTask, e, true);
    }
  };
}
