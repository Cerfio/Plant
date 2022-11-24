import { LogTaskService } from './../../common/LogTask';
import { UserAlreadyExistError, UserNotFound } from './user.exceptions';
import { LanguageEnum, User } from '@prisma/client';
import { PrismaError } from '../prisma/prisma.exception';
import prisma from '../prisma/prisma.client';

import { nanoid } from 'nanoid';

export class UserService {
  logTask: LogTaskService = new LogTaskService('UserService');
  constructor(readonly server: any) {}

  create = async (firstname: string, lastname: string, email: string, password: string | null) => {
    this.logTask.start('create');

    try {
      const user = await prisma.user.create({
        data: {
          language: LanguageEnum.FR,
          email: email,
          password: password,
          firstname: firstname,
          lastname: lastname,
        },
      });
      this.logTask.end('create');
      return user;
    } catch (e: any) {
      if (e.code === 'P2002') throw new UserAlreadyExistError(this.server);
      throw new PrismaError(this.server, this.logTask, e, true);
    }
  };

  update = async (userId: string, firstname: string | undefined, lastname: string | undefined) => {
    this.logTask.start('update');

    try {
      const user = await prisma.user.update({
        where: {
          id: userId,
        },
        data: {
          firstname: firstname,
          lastname: lastname,
        },
        include: {
          profile: true,
        },
      });
      this.logTask.end('update');
      return user;
    } catch (e: any) {
      throw new PrismaError(this.server, this.logTask, e, true);
    }
  };

  updatePassword = async (userId: string, password: string) => {
    this.logTask.start('updatePassword');

    try {
      await prisma.user.update({
        where: {
          id: userId,
        },
        data: {
          password: password,
        },
      });
    } catch (e: any) {
      throw new PrismaError(this.server, this.logTask, e, true);
    }
    this.logTask.end('updatePassword');
  };

  findByEmail = async (email: string) => {
    this.logTask.start('findByEmail');
    let user: User | null;
    try {
      user = await prisma.user.findUnique({
        where: { email },
      });
    } catch (e) {
      throw new PrismaError(this.server, this.logTask, e, true);
    }
    if (!user) {
      throw new UserNotFound(this.server);
    }
    this.logTask.end('findByEmail');
    return user;
  };

  findById = async (userId: string) => {
    this.logTask.start('findById');
    let user: User | null;
    try {
      user = await prisma.user.findUnique({ where: { id: userId } });
    } catch (e: any) {
      throw new PrismaError(this.server, this.logTask, e, true);
    }
    if (!user) {
      throw new UserNotFound(this.server, this.logTask);
    }
    this.logTask.end('findById');
    return user;
  };

  userEmailExist = async (email: string) => {
    this.logTask.start('userEmailExist');
    let user: User | null;
    try {
      user = await prisma.user.findUnique({ where: { email } });
    } catch (e: any) {
      throw new PrismaError(this.server, this.logTask, e, true);
    }
    this.logTask.end('userEmailExist');
    return !!user;
  };
}
