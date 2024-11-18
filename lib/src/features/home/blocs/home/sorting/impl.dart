import 'package:doctors_appointment/src/core/helpers/data_types/sorting_result.dart';
import 'package:doctors_appointment/src/features/home/blocs/home/sorting/interface.dart';
import 'package:doctors_appointment/src/features/home/models/doctor_data.dart';

class RecommendedDoctorsImpl implements SortingInterface{
  @override
  List<DoctorInfo> execute({
    required SortingResult result,
    required List<DoctorInfo> preSortedDoctorsList
}) {
    final selectedSpeciality = result.speciality;
    final selectedRating = result.rating;

    List<DoctorInfo> filteredDoctors = [];

    switch(selectedSpeciality){
      case 'All':
        return List.from(preSortedDoctorsList);
        // filteredDoctors = preSortedDoctorsList
        //     .where((doctor) => doctor.rating == selectedRating
        // ).toList(); --> this should be the actual condition

      default:
        return preSortedDoctorsList
            .where((doctor) => doctor.specialization.name == selectedSpeciality
            // && doctor.rating == selectedRating --> simulating existing rate data
        ).toList();
    }
  }
}

class SpecializationDoctorsImpl implements SortingInterface{
  @override
  List<DoctorInfo> execute({required SortingResult result, required List<DoctorInfo> preSortedDoctorsList}) {
    final rating = result.rating;

    final List<DoctorInfo> doctors = List.from(preSortedDoctorsList);
    
    switch(rating){
      case '5':
        return List.from(doctors);
        
      default:
        return List.from(doctors);
    // return doctors.where((doctor) =>
        // doctor.rating == 5.0 --> same simulating
        // ).toList();
    }
  }
}