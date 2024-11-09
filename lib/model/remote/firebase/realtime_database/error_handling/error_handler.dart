import 'package:doctors_appointment/model/remote/api_service/service/error_handling/error_checker.dart';
import 'package:firebase_core/firebase_core.dart';

class RealtimeDatabaseHandler{
  static ErrorInfo handleDatabaseError(FirebaseException e) {
    switch (e.code) {
      case 'database/permission-denied':
        return ErrorInfo('Check the permission rules');

      case 'database/network-error':
        return ErrorInfo('Check your internet connection');

      case 'database/timeout':
        return ErrorInfo('Timeout, Check your internet connection');

      default:
        return ErrorInfo('Try Again Later');
    }
  }
}