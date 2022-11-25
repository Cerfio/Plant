import { LogTaskService } from '../../common/LogTask';
import { PrismaError } from '../prisma/prisma.exception';
import prisma from '../prisma/prisma.client';
import { Plant, User } from '@prisma/client';
import { PlantNotFoundError } from '../plant/plant.exceptions';

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
