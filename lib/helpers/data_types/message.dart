import 'package:intl/intl.dart';

class Message {
  final String message;
  final String date;

  Message({
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