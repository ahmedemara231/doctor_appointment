import 'package:intl/intl.dart';

class ChatMessage {
  final String message;
  final String date;

  ChatMessage({
    required this.message,
    String? date,
  }) : date = date ?? DateFormat('dd-MM-yyyy / HH:mm').format(DateTime.now());

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'date': date,
    };
  }
}