import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../../../helpers/data_types/message.dart';
import '../error_handling/error_handler.dart';
import '../error_handling/firebase_error_handler.dart';
import '../interface.dart';

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
      throw RealTimeErrorHandler.handle(e);
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
  Future<String> sendMessage({
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

      return '';
    }on FirebaseException catch(e){
      throw RealTimeErrorHandler.handle(e);
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