class MakeAppComponent{
  final String doctorId;
  final String appointmentDate;
  final String appointmentTime;

  MakeAppComponent({
    required this.doctorId,
    required this.appointmentDate,
    required this.appointmentTime
  });


  Map<String, dynamic> toJson(){
    return {
      'doctor_id': doctorId,
      'start_time': appointmentDate + ' ' + appointmentTime,
    };
  }
}