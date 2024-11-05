import 'package:firebase_database/firebase_database.dart';
import 'dart:developer';
class PatientsDataSource{
  late DatabaseReference patientsRef;
  void initDatabase()async{
    patientsRef = FirebaseDatabase.instance.ref('users/Patients');
  }

  Future<void> sendMessage()async{
    await patientsRef.set({
      // "name": "John",
      // "age": 18,
      // "address": {
      //   "line1": "100 Mountain View"
      // }
    });
    log('sent');
  }

  Future<void> getMessage()async{
    patientsRef.onValue.listen((event) {
      log(event.snapshot.value.toString());
    });
  }
}