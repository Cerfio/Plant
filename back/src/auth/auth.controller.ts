import bcrypt from 'bcrypt';
import { ISignInInput } from './dtos/auth.signin.input';
import { ISignUpInput } from './dtos/auth.signup.input';
import { AuthService } from './auth.service';
import { LogTaskController } from './../../common/LogTask';
import { UserService } from '../user/user.service';
import { GoogleService } from '../google/google.service';
import { User } from '@prisma/client';
import { UserUsedGoogleAccount } from '../google/google.exceptions';
import { SendgridService } from '../sendgrid/sendgrid.service';
import { UserPasswordError } from '../user/user.exceptions';

export class AuthController {
  logTask: LogTaskController = new LogTaskController('AuthController');
  authService: AuthService = new AuthService(this.server);
  userService: UserService = new UserService(this.server);
  googleService: GoogleService = new GoogleService(this.server);
  sendgridService: SendgridService = new SendgridService(this.server);
  constructor(readonly server: any) {}

  signIn = async (request: any, reply: any) => {
    this.logTask.start('signIn');
    const input: ISignInInput = request.body;

    const user = await this.userService.findByEmail(input.email);

    if (user.password === null) {
      throw new UserUsedGoogleAccount(this.server, this.logTask);
    }
    if (!(await bcrypt.compare(input.password, user.password))) {
      throw new UserPasswordError(this.server);
    }
    const token = await this.authService.createJwt(user.id);
    this.logTask.end('signIn');
    reply.code(200).send({ message: token });
  };

  signUp = async (request: any, reply: any) => {
    this.logTask.start('signUp');
    const input: ISignUpInput = request.body;

    input.password = await bcrypt.hash(input.password, this.server.config.SALT_ROUNDS);
    await this.userService.create(
      input.firstname,
      input.lastname,
      input.email,
      input.password,
    );
    this.logTask.end('signUp');
    reply.code(200).send({ message: true });
  };

  emailAvailable = async (request: any, reply: any) => {
    this.logTask.start('emailAvailable');
    const email = request.query.email;

    const emailAlreadyExist = await this.userService.userEmailExist(email);
    this.logTask.end('emailAvailable');
    reply.code(200).send({ message: emailAlreadyExist });
  };
}
