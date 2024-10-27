class AllDoctorsData{
  List<dynamic> data;
  AllDoctorsData({required this.data});
  factory AllDoctorsData.fromJson(Map<String, dynamic> json) => AllDoctorsData(
    data: json['data'].map((data) => DoctorsInSpecificField.fromJson(data)).toList(),
  );
}
//                         doctor Index
// state.homeData![index].allInfo[0].name
class DoctorsInSpecificField{
  String fieldName;
  List<dynamic> allInfo;

  DoctorsInSpecificField({required this.allInfo, required this.fieldName});

  factory DoctorsInSpecificField.fromJson(Map<String, dynamic> json) =>
      DoctorsInSpecificField(
        allInfo: json['doctors'].map((data) => DoctorInfo.fromJson(data)).toList(),
        fieldName: json['name'],
      );
}

class DoctorInfo {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String photo;
  final String gender;
  final String address;
  final String description;
  Specialization specialization;
  CityInfo city;
  int appointPrice;
  String startTime;
  String endTime;
  DoctorInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.gender,
    required this.address,
    required this.description,
    required this.specialization,
    required this.city,
    required this.appointPrice,
    required this.startTime,
    required this.endTime,
});
  factory DoctorInfo.fromJson(Map<String, dynamic> json) => DoctorInfo(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    phone: json['phone'],
    photo: json['photo'],
    gender: json['gender'],
    address: json['address'],
    description: json['description'],
    specialization: Specialization.fromJson(json['specialization']),
    city: CityInfo.fromJson(json['city']),
    appointPrice: json['appoint_price'],
    startTime: json['start_time'],
    endTime: json['end_time'],
  );
}

class CityInfo {
  final int id;
  final String name;
  final GovernrateInfo governate;

  CityInfo({
    required this.id,
    required this.name,
    required this.governate,
  });
  factory CityInfo.fromJson(Map<String, dynamic> json) => CityInfo(
    id: json['id'],
    name: json['name'],
    governate: GovernrateInfo.fromJson(json['governrate']),
  );
}

class GovernrateInfo {
  final int id;
  final String name;

  GovernrateInfo({
    required this.id,
    required this.name,
  });
  factory GovernrateInfo.fromJson(Map<String, dynamic> json) => GovernrateInfo(
    id: json['id'],
    name: json['name'],
  );
}

class Specialization {
  final int id;
  final String name;

  Specialization({
    required this.id,
    required this.name,
  });
  factory Specialization.fromJson(Map<String, dynamic> json) => Specialization(
    id: json['id'],
    name: json['name'],
  );
}