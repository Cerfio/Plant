import { LogTaskService } from '../../common/LogTask';
import { PrismaError } from '../prisma/prisma.exception';

import { SENDGRID_EMAIL_TEMPLATE } from './sendgrid.enum';

const sgMail = require('@sendgrid/mail');
sgMail.setApiKey(process.env.SENDGRID_API_KEY);

export class SendgridService {
  logTask: LogTaskService = new LogTaskService('SendgridService');
  constructor(readonly server: any) {}

  sendEmail = async (email: string, templateId: SENDGRID_EMAIL_TEMPLATE, data: any) => {
    this.logTask.start('sendEmail');

    try {
      sgMail.send({
        to: email,
        from: {
          email: 'team@onefive.fr',
          name: 'One Five',
        },
        templateId,
        dynamic_template_data: {
          ...data,
        },
      });
    } catch (e) {
      throw new PrismaError(this.server, this.logTask, e, true);
    }
    this.logTask.end('sendEmail');
  };
}
