import { LogTaskController } from '../../common/LogTask';
import { PlantService } from './plant.service';
import axios from 'axios';
import { PlantDeleteNotAuthorizedError, PlantGeneratorNameError, PlantNotFoundError } from './plant.exceptions';

export class PlantController {
  logTask: LogTaskController = new LogTaskController('PlantController');
  plantService: PlantService = new PlantService(this.server);
  constructor(readonly server: any) {}

  create = async (request: any, reply: any) => {
    this.logTask.start('create');
    let name = '';

    try {
      const names = await axios.get('https://fungenerators.com/name/user/');
      name = names.data.split('<div class="name wow fadeInUp animated"  data-wow-delay=".6s">')[1].split('</div>')[0];
    } catch (e: any) {
      throw new PlantGeneratorNameError(this.server);
    }
    await this.plantService.create(request.user.id, name, request.body.macAddress, request.body.serialNumber);
    this.logTask.end('create');
    reply.code(200).send({ message: name });
  };

  delete = async (request: any, reply: any) => {
    this.logTask.start('delete');

    const plant = await this.plantService.findById(request.params.id);

    if (plant.isEnable === false) {
      throw new PlantNotFoundError(this.server);
    }
    if (plant.user.id !== request.user.id) {
      throw new PlantDeleteNotAuthorizedError(this.server);
    }
    await this.plantService.delete(request.params.id);

    this.logTask.end('delete');
    reply.code(200).send({ message: true });
  };

  gets = async (request: any, reply: any) => {
    this.logTask.start('gets');
    const plants = await this.plantService.findMany(request.user.id);
    this.logTask.end('gets');
    reply.code(200).send(plants);
  }

  get = async (request: any, reply: any) => {
    this.logTask.start('get');
    const plant = await this.plantService.findById(request.params.id);
    this.logTask.end('get');
    reply.code(200).send(plant);
  }
}
