class UserAppointmentDetails {
  final String appointmentDate;
  final String appointmentTime;
  final String appointmentType;

  UserAppointmentDetails({
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentType,
  });

  Map<String, dynamic> toJson(){
    return {
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'appointmentType': appointmentType,
    };
  }
  // UserAppointmentDetails copyWith({
  //   DateTime? dateTime, String? appointmentType, bool? pay
  // }) {
  //   return UserAppointmentDetails(
  //       dateTime: dateTime ?? this.dateTime,
  //       appointmentType: appointmentType ?? this.appointmentType,
  //       pay: pay ?? this.pay
  //   );
  // }
}
