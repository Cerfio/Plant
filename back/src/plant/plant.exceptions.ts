import { BadRequestException, InternalErrorException, NotFoundException } from '../../common/exceptions';

export class PlantAlreadyExistError extends InternalErrorException {}
export class PlantGeneratorNameError extends InternalErrorException {}
export class PlantNotFoundError extends NotFoundException {}
export class PlantDeleteNotAuthorizedError extends BadRequestException {}