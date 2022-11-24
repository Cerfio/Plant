import * as Sentry from '@sentry/node';
import { LogTaskController, LogTaskDecorator, LogTaskService, LogTaskHandler } from './LogTask';

export class UnavailableForLegalReasonsException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.unavailableForLegalReasons(this.constructor.name);
  }
}

export class RequestHeaderFieldsTooLargeException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.requestHeaderFieldsTooLarge(this.constructor.name);
  }
}

export class TooManyRequestsException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.tooManyRequests(this.constructor.name);
  }
}

export class PreconditionRequiredException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.preconditionRequired(this.constructor.name);
  }
}
export class UpgradeRequiredException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.upgradeRequired(this.constructor.name);
  }
}

export class UnorderedCollectionException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.unorderedCollection(this.constructor.name);
  }
}

export class FailedDependencyException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.failedDependency(this.constructor.name);
  }
}

export class LockedException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.locked(this.constructor.name);
  }
}

export class BadRequestException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.badRequest(this.constructor.name);
  }
}

export class UnauthorizedException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.unauthorized(this.constructor.name);
  }
}

export class PaymentRequiredException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.paymentRequired(this.constructor.name);
  }
}

export class ForbiddenException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.forbidden(this.constructor.name);
  }
}

export class NotFoundException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.notFound(this.constructor.name);
  }
}

export class MethodNotAllowedException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.methodNotAllowed(this.constructor.name);
  }
}

export class ProxyAuthenticationRequiredException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.proxyAuthenticationRequired(this.constructor.name);
  }
}

export class NotAcceptableException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.notAcceptable(this.constructor.name);
  }
}

export class GoneException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.gone(this.constructor.name);
  }
}

export class ConflictException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.conflict(this.constructor.name);
  }
}

export class RequestTimeoutException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.requestTimeout(this.constructor.name);
  }
}

export class UnsupportedMediaTypeException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.unsupportedMediaType(this.constructor.name);
  }
}

export class UriTooLongException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.uriTooLong(this.constructor.name);
  }
}

export class PayloadTooLargeException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.payloadTooLarge(this.constructor.name);
  }
}

export class PreconditionFailedException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.preconditionFailed(this.constructor.name);
  }
}

export class LengthRequiredException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.lengthRequired(this.constructor.name);
  }
}

export class UnprocessableEntityException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.unprocessableEntity(this.constructor.name);
  }
}

export class MisdirectedRequestException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.misdirectedRequest(this.constructor.name);
  }
}

export class ImateapotException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.imateapot(this.constructor.name);
  }
}

export class ExpectationFailedException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.expectationFailed(this.constructor.name);
  }
}

export class RangeNotSatisfiableException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.rangeNotSatisfiable(this.constructor.name);
  }
}

export class InternalErrorException {
  constructor(
    server: any,
    logger?: LogTaskService | LogTaskController | LogTaskDecorator | LogTaskHandler,
    error?: any,
    sentry?: boolean,
  ) {
    if (sentry) {
      Sentry.captureException(error ?? this.constructor.name);
    }
    logger && logger.error(error ?? this.constructor.name);
    throw server.httpErrors.internalServerError(this.constructor.name);
  }
}
