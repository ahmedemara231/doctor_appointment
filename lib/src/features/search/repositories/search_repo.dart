import 'package:doctors_appointment/src/core/data_source/remote/api_service/extensions/future.dart';
import 'package:doctors_appointment/src/core/data_source/remote/api_service/service/error_handling/base_remote_error_class.dart';
import 'package:doctors_appointment/src/core/data_source/remote/firebase/realtime_database/services/extensions/future.dart';
import 'package:doctors_appointment/src/features/home/models/doctor_data.dart';
import 'package:doctors_appointment/src/features/search/data_source/whole_search_data_source.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../core/data_source/remote/firebase/realtime_database/services/error_handling/firebase_error_handler.dart';

class SearchRepo{
  final WholeSearchDataSource dataSource;
  SearchRepo(this.dataSource);

  Future<Result<List<DoctorInfo>, RemoteError>> search(String doctorName)async{
   return dataSource
        .search(doctorName)
        .handleApiCalls();
  }
  Future<Result<String, FirebaseError>> storeSearchResult(String result)async{
    return dataSource.storeSearchResult(result).handleFirebaseCalls();
  }
}