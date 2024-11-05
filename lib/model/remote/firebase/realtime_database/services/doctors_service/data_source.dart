import 'package:firebase_database/firebase_database.dart';
import 'dart:developer';
class DoctorsDataSource{
  late DatabaseReference doctorsRef;
  void initDatabase()async{
    doctorsRef = FirebaseDatabase.instance.ref('users/Doctors');
  }

  Future<void> sendMessage()async{
    await doctorsRef.set({
      // "name": "John",
      // "age": 18,
      // "address": {
      //   "line1": "100 Mountain View"
      // }
    });
    log('sent');
  }

  Future<void> getMessage()async{
    doctorsRef.onValue.listen((event) {
      log(event.snapshot.value.toString());
    });
  }
}