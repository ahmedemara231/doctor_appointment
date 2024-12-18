import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../../../../helpers/data_types/message.dart';
import '../error_handling/error_handler.dart';
import '../error_handling/firebase_error_handler.dart';
import '../interface.dart';

class PatientsDataSource implements RealtimeServices{
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

  DatabaseReference initRef(String emailPart){
    patientsRef = FirebaseDatabase.instance.ref(
        'users/patients/$emailPart'
    );

    return patientsRef;
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

  @override
  Future<List<int>> getPeopleIdsWhichUserChatWith()async{
    try{
      List<int> doctorsIds = [];
      DatabaseReference reference = patientsRef
          .child('chats');
      DataSnapshot snapshot = await reference.get();
      for (var child in snapshot.children) {
        doctorsIds.add(int.parse(child.key!));
      }

      return doctorsIds;
    }on FirebaseException catch(e){
      throw RealTimeErrorHandler.handle(e);
    }
  }

  // Future<int> get _calcNumberOfSearchResults async{
  //   late int searchResultsLength;
  //   DatabaseReference reference = patientsRef.child('searchHistory');
  //   DataSnapshot snapshot = await reference.get();
  //   searchResultsLength = snapshot.children.length;
  //   return searchResultsLength;
  // }

  Future<String> storeSearchResult(String result)async{
    try{
      await patientsRef
          .child('searchHistory')
          .child(result)
          .set({'searchAbout' : result});
          // .child('s${await _calcNumberOfSearchResults + 1}')
          // .set({'searchResult' : result});

      return '';
    }on FirebaseException catch(e){
      throw RealTimeErrorHandler.handle(e);
    }
  }
  
}