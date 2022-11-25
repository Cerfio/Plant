import { LogTaskController } from '../../common/LogTask';
import { PlantDataService } from './plantData.service';
import { PlantService } from '../plant/plant.service';

export class PlantDataController {
  logTask: LogTaskController = new LogTaskController('PlantController');
  plantService: PlantService = new PlantService(this.server);
  plantDataService: PlantDataService = new PlantDataService(this.server);
  constructor(readonly server: any) {}

  create = async (
    serialNumber: string,
    temperature: number,
    humiditySoil: number,
    humidityAir: number,
    light: number,
    battery: number,
    pressure: number,
  ) => {
    this.logTask.start('create');

    try {
      const plant = await this.plantService.findBySerialNumber(serialNumber);
      await this.plantDataService.create(plant.id, temperature, humiditySoil, humidityAir, light, battery, pressure);
    } catch (error) {
      console.log(error);
    }
    this.logTask.end('create');
    return { message: 'Plant Data Created' };
  };
}
