import { LogTaskController } from '../../common/LogTask';
import { UserService } from './user.service';

export class UserController {
  logTask: LogTaskController = new LogTaskController('UserController');
  userService: UserService = new UserService(this.server);
  constructor(readonly server: any) {}

  update = async (request: any, reply: any) => {
    this.logTask.start('update');

    await this.userService.update(request.user.id, request.body.firstname, request.body.lastname);
    this.logTask.end('update');
    reply.code(200).send({ message: true });
  };
}
