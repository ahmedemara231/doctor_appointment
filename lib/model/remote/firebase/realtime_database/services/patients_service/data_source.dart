import 'package:doctors_appointment/helpers/data_types/message.dart';
import 'package:doctors_appointment/model/remote/firebase/realtime_database/error_handling/error_handler.dart';
import 'package:doctors_appointment/model/remote/firebase/realtime_database/services/interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../error_handling/firebase_error_handler.dart';

class PatientsDataSource implements ChatWith{
  late DatabaseReference patientsRef;
  static PatientsDataSource? _instance;
  PatientsDataSource._internal();
  static PatientsDataSource getInstance(){
    return _instance ??= PatientsDataSource._internal();
  }

  void databaseConfig(){
    FirebaseDatabase.instance
      ..setLoggingEnabled(true)
      ..setPersistenceEnabled(true)
      ..goOnline();
  }

  void initRef(String emailPart)async{
    patientsRef = FirebaseDatabase.instance.ref(
        'users/patients/$emailPart'
    );
  }

  Future<Result<void, FirebaseError>> registerAccountOnRealtimeDatabase({
    required String name,
    required String email
  })async{
    try{
      initRef(email.split("@").first);
      await patientsRef.set({
        'name': name,
        'email' : email,
      });

      return const Result.success(null);
    }on FirebaseException catch(e){
      return Result.error(RealTimeErrorHandler.handle(e));
    }
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

  @override
  Future<Result<void, FirebaseError>> sendMessage({
    required String message,
    required int receiverId
  })async{
    try{
      ChatMessage finalMessage = ChatMessage(message: message);
      await patientsRef
          .child('chats')
          .child(receiverId.toString()) // number
          .child('messages')
          .child('m${(await _calcNumberOfMessages(receiverId)) + 1}')
          .set(finalMessage.toJson());

      return const Result.success(null);
    }on FirebaseException catch(e){
      return Result.error(RealTimeErrorHandler.handle(e));
    }
  }

  @override
  Stream<DatabaseEvent> getMessages(int receiverId){
    return patientsRef
        .child('chats')
        .child(receiverId.toString()) // number
        .child('messages')
        .onValue;
  }
}