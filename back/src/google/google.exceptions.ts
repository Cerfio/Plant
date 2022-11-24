import { BadRequestException, InternalErrorException } from '../../common/exceptions';

export class GoogleGetAccessTokenError extends InternalErrorException {}
export class GoogleError extends InternalErrorException {}
export class GoogleUploadError extends InternalErrorException {}
export class GoogleDeleteError extends InternalErrorException {}
export class GoogleUserInfoError extends InternalErrorException {}
export class UserUsedGoogleAccount extends BadRequestException {}
