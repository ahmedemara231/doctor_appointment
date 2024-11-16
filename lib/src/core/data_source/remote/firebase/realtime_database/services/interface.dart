import 'package:firebase_database/firebase_database.dart';

abstract interface class ChatWith{
  Future<String> sendMessage({
    required String message,
    required int receiverId
  });

  Stream<DatabaseEvent> getMessages(int receiverId);

  Future<List<int>> getPeopleIdsWhichUserChatWith();
}