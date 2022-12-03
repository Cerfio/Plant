import { LogTaskService } from '../../common/LogTask';
import { NotificationNotFoundError } from './notification.exception';
import { PrismaError } from '../prisma/prisma.exception';
import prisma from '../prisma/prisma.client';
import { Notification, NotificationType } from '@prisma/client';

export class NotificationService {
  logTask: LogTaskService = new LogTaskService('NotificationService');
  constructor(readonly server: any) {}

  create = async (userId: string, type: NotificationType) => {
    this.logTask.start('create');
    try {
      await prisma.notification.create({
        data: {
          type,
          userId: userId,
        },
      });
      this.logTask.end('create');
    } catch (error: any) {
      throw new PrismaError(this.server, this.logTask, error, true);
    }
    this.logTask.end('create');
  };

  findByUserId = async (userId: string) => {
    this.logTask.start('findByUserId');
    let notifications: Notification[] = [];
    try {
      notifications = await prisma.notification.findMany({
        where: {
          userId,
        },
      });
      this.logTask.end('findByUserId');
    } catch (error: any) {
      throw new PrismaError(this.server, this.logTask, error, true);
    }
    return notifications;
  };

  updateIsRead = async (userId: string, isRead: boolean) => {
    this.logTask.start('updateIsRead');
    try {
      await prisma.notification.updateMany({
        where: {
          userId,
        },
        data: {
          isRead,
        },
      });
      this.logTask.end('updateIsRead');
    } catch (error: any) {
      throw new PrismaError(this.server, this.logTask, error, true);
    }
  };
}
