class UserAppointmentDetails {
  DateTime? dateTime;
  String? appointmentType;
  bool pay;

  UserAppointmentDetails({
    this.dateTime,
    this.appointmentType,
    this.pay = false,
  });

  UserAppointmentDetails copyWith({
    DateTime? dateTime, String? appointmentType, bool? pay
  }) {
    return UserAppointmentDetails(
        dateTime: dateTime ?? this.dateTime,
        appointmentType: appointmentType ?? this.appointmentType,
        pay: pay ?? this.pay
    );
  }
}
