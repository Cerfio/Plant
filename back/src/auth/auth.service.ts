import { LogTaskService } from './../../common/LogTask';

export class AuthService {
  logTask: LogTaskService = new LogTaskService('AuthService');
  constructor(readonly server: any) {}

  createJwt = async (id: string): Promise<string> => {
    this.logTask.start('createJwt');

    const token: string = this.server.jwt.sign({ id });

    this.logTask.end('createJwt');
    return token;
  };
}
