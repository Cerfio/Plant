import { BadRequestException, InternalErrorException, NotFoundException } from './../../common/exceptions';

export class UserAlreadyExistError extends BadRequestException {}
export class UserGetError extends BadRequestException {}
export class UserNotFound extends NotFoundException {}
export class UserPasswordError extends BadRequestException {}
export class UserEmailNotVerified extends BadRequestException {}
export class UserProfileIsNullError extends InternalErrorException {}
