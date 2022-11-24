import fp from 'fastify-plugin';
import { LogTaskDecorator } from './../../common/LogTask';
import { JWTVerifyError } from './jwt.exception';
import { UserService } from '../user/user.service';

const logTask: LogTaskDecorator = new LogTaskDecorator('JWTDecorator');

export default fp(async (server: any) => {
  server.decorate('authenticate', async (request: any) => {
    logTask.start('jwt');

    try {
      await request.jwtVerify();
    } catch (err) {
      throw new JWTVerifyError(server, logTask);
    }
    logTask.end('jwt');
  });

  server.decorate('authenticateUser', async (request: any) => {
    logTask.start('jwtUser');
    const userService = new UserService(server);

    try {
      await request.jwtVerify();
      request.user = await userService.findById(request.user.id);
    } catch (err) {
      throw new JWTVerifyError(server, logTask);
    }
    logTask.end('jwtUser');
  });
});
