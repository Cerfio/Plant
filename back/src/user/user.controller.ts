import { LogTaskController } from '../../common/LogTask';
import { UserNeedToBeAdminError } from './user.exceptions';
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

  gets = async (request: any, reply: any) => {
    this.logTask.start('gets');

    const user = await this.userService.findById(request.user.id);

    if (user.admin === false) {
      throw new UserNeedToBeAdminError(this.server);
    }

    const users = await this.userService.findMany(request.query.search ?? '');
    this.logTask.end('gets');
    reply.code(200).send(users);
  }
}
