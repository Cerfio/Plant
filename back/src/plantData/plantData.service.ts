import { LogTaskService } from '../../common/LogTask';
import { PlantAlreadyExistError, PlantNotFoundError } from './plant.exceptions';
import { PrismaError } from '../prisma/prisma.exception';
import prisma from '../prisma/prisma.client';
import { Plant, User } from '@prisma/client';

export class PlantDataService {
  logTask: LogTaskService = new LogTaskService('PlantDataService');
  constructor(readonly server: any) {}

  create = async (
    plantId: string,
    temperature: number,
    humiditySoil: number,
    humidityAir: number,
    light: number,
    battery: number,
    pressure: number,
  ) => {
    this.logTask.start('create');

    try {
      await prisma.plantData.create({
        data: {
          battery,
          humiditySoil,
          light,
          pressure,
          temperature,
          humidityAir,
          plant: {
            connect: {
              id: plantId,
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
}
