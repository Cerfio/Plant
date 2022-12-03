import { NotificationType } from '@prisma/client';

export const notificationGetsResponseSchema = {
  '2xx': {
    type: 'array',
    items: {
      type: 'object',
      properties: {
        id: { type: 'string' },
        isRead: { type: 'boolean' },
        type: { type: 'string', enum: Object.values(NotificationType) },
        userId: { type: 'string' },
        createdAt: { type: 'string' },
        updatedAt: { type: 'string' },
      },
    },
  },
};
