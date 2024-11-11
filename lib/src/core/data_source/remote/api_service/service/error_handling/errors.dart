import 'base_remote_error_class.dart';

class NetworkError extends RemoteError {
  NetworkError(super.message);
}

class BadResponseError extends RemoteError {
  BadResponseError(super.message);
}

class BadRequestError extends RemoteError {
  BadRequestError(super.message);
}

class UnAuthorizedError extends RemoteError {
  UnAuthorizedError(super.message);
}

class NotFoundError extends RemoteError {
  NotFoundError(super.message);
}

class ConflictError extends RemoteError {
  ConflictError(super.message);
}

class UnprocessableEntityError extends RemoteError {
  UnprocessableEntityError(super.message);
}

class BadCertificateError extends RemoteError {
  BadCertificateError(super.message);
}

class CancelError extends RemoteError {
  CancelError(super.message);
}

class UnknownError extends RemoteError {
  UnknownError(super.message);
}