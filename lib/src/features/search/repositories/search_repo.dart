import 'package:doctors_appointment/src/core/data_source/remote/api_service/extensions/future.dart';
import 'package:doctors_appointment/src/core/data_source/remote/api_service/service/error_handling/base_remote_error_class.dart';
import 'package:doctors_appointment/src/features/home/models/doctor_data.dart';
import 'package:doctors_appointment/src/features/search/data_source/whole_search_data_source.dart';
import 'package:multiple_result/multiple_result.dart';

class SearchRepo{
  final WholeSearchDataSource _dataSource;
  SearchRepo(this._dataSource);

  Future<Result<List<DoctorInfo>, RemoteError>> search(String doctorName)async{
   return _dataSource
        .search(doctorName)
        .handleApiCalls();
  }
}