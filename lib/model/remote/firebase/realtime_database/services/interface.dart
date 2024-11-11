import 'package:doctors_appointment/model/remote/firebase/realtime_database/error_handling/firebase_error_handler.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class ChatWith{
  Future<Result<void, FirebaseError>> sendMessage({
    required String message,
    required int receiverId
  });

  Stream<DatabaseEvent> getMessages(int receiverId);
}