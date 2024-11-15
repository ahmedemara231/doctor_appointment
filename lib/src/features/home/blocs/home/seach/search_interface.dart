import 'package:doctors_appointment/src/features/home/models/doctor_data.dart';

abstract class Search{
  static List<DoctorInfo> execute({
    required List<DoctorInfo> fullList,
    required String pattern
  }){
    List<DoctorInfo> result = [];
    if(pattern.isEmpty){
      return List.from(fullList);
    }else{
      result = fullList
          .where((element) => element.name.toLowerCase().contains(pattern))
          .toList();
    }
    return result;
  }
}