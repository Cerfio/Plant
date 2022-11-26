import { LogTaskService } from '../../common/LogTask';
import { PlantAlreadyExistError, PlantNotFoundError } from './plant.exceptions';
import { PrismaError } from '../prisma/prisma.exception';
import prisma from '../prisma/prisma.client';
import { Plant, PlantData, User } from '@prisma/client';

export class PlantService {
  logTask: LogTaskService = new LogTaskService('PlantService');
  constructor(readonly server: any) {}

  create = async (userId: string, name: string, macAddress: string, serialNumber: string) => {
    this.logTask.start('create');

    try {
      await prisma.plant.create({
        data: {
          name,
          isEnable: true,
          macAddress,
          serialNumber,
          user: {
            connect: {
              id: userId,
            },
          },
          datas: {
            create: {
              temperature: 0,
              humidityAir: 0,
              light: 0,
              humiditySoil: 0,
              battery: 0,
              pressure: 0,
            },
          },
        },
      });
      this.logTask.end('create');
    } catch (e: any) {
      throw new PrismaError(this.server, this.logTask, e, true);
    }
  };

  findById = async (id: string) => {
    this.logTask.start('findById');

    let plant:
      | (Plant & {
          user: User;
        })
      | null = null;

    try {
      plant = await prisma.plant.findUnique({
        where: {
          id,
        },
        include: {
          user: true,
          datas: {
            where: {
              createdAt: {
                gte: new Date(new Date().setDate(new Date().getDate() - 7)),
              },
            },
          },
        },
      });
    } catch (e: any) {
      throw new PrismaError(this.server, this.logTask, e, true);
    }
    if (!plant) {
      throw new PlantNotFoundError(this.server, this.logTask);
    }
    this.logTask.end('findById');
    return plant;
  };

  delete = async (id: string) => {
    this.logTask.start('delete');

    try {
      await prisma.plant.update({
        where: {
          id,
        },
        data: {
          isEnable: false,
        },
        include: {
          user: true,
        },
      });
      this.logTask.end('delete');
    } catch (e: any) {
      throw new PrismaError(this.server, this.logTask, e, true);
    }
    this.logTask.end('delete');
  };

  findMany = async (userId: string) => {
    this.logTask.start('findMany');

    let plants: Plant[] = [];

    try {
      plants = await prisma.plant.findMany({
        where: {
          userId,
          isEnable: true,
        },
        include: {
          datas: {
            where: {
              createdAt: {
                gte: new Date(new Date().setDate(new Date().getDate() - 7)),
              },
            },
          },
        },
      });
    } catch (e: any) {
      throw new PrismaError(this.server, this.logTask, e, true);
    }
    this.logTask.end('findMany');
    return plants;
  };

  findBySerialNumber = async (serialNumber: string) => {
    this.logTask.start('findBySerialNumber');

    let plant: Plant | null = null;

    try {
      plant = await prisma.plant.findFirst({
        where: {
          serialNumber,
          isEnable: true,
        },
      });
    } catch (e: any) {
      throw new PrismaError(this.server, this.logTask, e, true);
    }
    if (!plant) {
      throw new PlantNotFoundError(this.server, this.logTask);
    }
    this.logTask.end('findBySerialNumber');
    return plant;
  };

  findManyByUserId = async (userId: string) => {
    this.logTask.start('findManyByUserId');

    let plants: (Plant & {
      datas: PlantData[];
    })[] = [];

    try {
      plants = await prisma.plant.findMany({
        where: {
          userId,
        },
        include: {
          datas: {
            orderBy: {
              createdAt: 'desc',
            },
          },
        },
      });
    } catch (e: any) {
      throw new PrismaError(this.server, this.logTask, e, true);
    }
    this.logTask.end('findManyByUserId');
    return plants;
  };
}
