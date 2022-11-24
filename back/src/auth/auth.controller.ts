import bcrypt from 'bcrypt';
import { ISignInInput } from './dtos/auth.signin.input';
import { ISignUpInput } from './dtos/auth.signup.input';
import { AuthService } from './auth.service';
import { LogTaskController } from './../../common/LogTask';
import { UserService } from '../user/user.service';
import { UserEmailNotVerified, UserPasswordError } from '../user/user.exceptions';
import { GoogleService } from '../google/google.service';
import { RoleProfileType, User } from '@prisma/client';
import { UserUsedGoogleAccount } from '../google/google.exceptions';
import { SendgridService } from '../sendgrid/sendgrid.service';
import { SENDGRID_EMAIL_TEMPLATE } from '../sendgrid/sendgrid.enum';

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
    if (user.emailSignupVerification.length === 0) {
      throw new UserEmailNotVerified(this.server);
    }
    const token = await this.authService.createJwt(user.id);
    this.logTask.end('signIn');
    reply.code(200).send({ message: token });
  };

  signUp = async (request: any, reply: any) => {
    this.logTask.start('signUp');
    const input: ISignUpInput = request.body;

    input.password = await bcrypt.hash(input.password, this.server.config.SALT_ROUNDS);
    const user = await this.userService.create(
      input.firstname,
      input.lastname,
      input.email,
      input.password,
      input.newsletter,
      input.role,
      true,
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

  authGoogle = async (request: any, reply: any) => {
    this.logTask.start('authGoogle');
    const accessToken = await this.googleService.getAccessTokenFromCode(request.body.code);
    const googleUser = await this.googleService.getGoogleUserInfo(accessToken);
    let user: User;
    try {
      user = await this.userService.findByEmail(googleUser.email);
    } catch (e: any) {
      if (e.statusCode !== 404) throw e;
      user = await this.userService.create(
        googleUser.given_name,
        googleUser.family_name,
        googleUser.email,
        null,
        true,
        RoleProfileType.ENTREPRENEUR,
        false,
      );
    }
    const token = await this.authService.createJwt(user.id);
    this.logTask.end('authGoogle');
    reply.code(200).send({ token });
  };
}
