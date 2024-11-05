import 'package:doctors_appointment/helpers/data_types/message.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:developer';
class PatientsDataSource{
  late DatabaseReference patientsRef;
  static PatientsDataSource? _instance;
  PatientsDataSource._internal();
  static PatientsDataSource getInstance(){
    return _instance ??= PatientsDataSource._internal();
  }

  void initRef(String emailPart)async{
    patientsRef = FirebaseDatabase.instance.ref(
        'users/patients/$emailPart'
    );
  }

  Future<void> registerAccountOnRealtimeDatabase({required String name, required String email})async{
    initRef(email.split("@").first);
    await patientsRef.set({
      'name': name,
      'email' : email,
    });
    log('Registered');
  }

   Future<int> _calcNumberOfMessages(int docId) async{
    late int messagesLength;
    DatabaseReference reference = patientsRef
        .child('chats')
        .child(docId.toString())
        .child('messages');
    DataSnapshot snapshot = await reference.get();
    messagesLength = snapshot.children.length;
    return messagesLength;
  }

  Future<void> sendMessage({
    required String message,
    required int doctorId
  })async{
    Message finalMessage = Message(message: message);
    await patientsRef
        .child('chats')
        .child(doctorId.toString()) // number
        .child('messages')
        .child('m${(await _calcNumberOfMessages(doctorId)) + 1}')
        .set(finalMessage.toJson());
  }












  Future<void> getMessage()async{
    patientsRef.onValue.listen((event) {
      log(event.snapshot.value.toString());
    });
  }
}