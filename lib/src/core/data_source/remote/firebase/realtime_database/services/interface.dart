import 'package:firebase_database/firebase_database.dart';
import 'package:multiple_result/multiple_result.dart';
import 'error_handling/firebase_error_handler.dart';

abstract interface class ChatWith{
  Future<String> sendMessage({
    required String message,
    required int receiverId
  });

  Stream<DatabaseEvent> getMessages(int receiverId);
}