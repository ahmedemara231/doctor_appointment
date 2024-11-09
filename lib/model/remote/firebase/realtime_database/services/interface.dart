import 'package:firebase_database/firebase_database.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../api_service/service/error_handling/error_checker.dart';

abstract interface class ChatWith{
  Future<Result<void, ErrorInfo>> sendMessage({
    required String message,
    required int receiverId
  });

  Stream<DatabaseEvent> getMessages(int receiverId);
}