class UserAppointmentDetails {
  String? dateTime;
  String? appointmentType;
  bool pay;

  UserAppointmentDetails({
    this.dateTime,
    this.appointmentType,
    this.pay = false,
  });
}
