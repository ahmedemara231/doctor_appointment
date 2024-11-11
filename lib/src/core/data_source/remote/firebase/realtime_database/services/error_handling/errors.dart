import 'firebase_error_handler.dart';

class UnavailableError extends FirebaseError{
  UnavailableError(super.errorMessage);
}

class PermissionDeniedError extends FirebaseError {
  PermissionDeniedError(super.errorMessage);
}

class DefaultError extends FirebaseError {
  DefaultError(super.errorMessage);
}