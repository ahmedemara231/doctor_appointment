import 'package:doctors_appointment/src/core/helpers/data_types/sorting_result.dart';
import 'package:doctors_appointment/src/features/home/models/doctor_data.dart';

abstract interface class SortingInterface{
  List<DoctorInfo> execute({
    required SortingResult result,
    required List<DoctorInfo> preSortedDoctorsList
  });
}