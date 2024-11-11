import 'package:doctors_appointment/src/core/data_source/remote/firebase/realtime_database/services/error_handling/firebase_error_handler.dart';
import 'package:multiple_result/multiple_result.dart';

extension ErrorHandler<T extends Object> on Future<T> {
  Future<Result<T, FirebaseError>> handleFirebaseCalls()async{
    try{
      final T result = await this;
      return Result.success(result);
    } on FirebaseError catch(e){
      return Result.error(e);
    }
  }
}