import 'package:dio/dio.dart';
import 'package:doctors_appointment/src/core/data_source/remote/api_service/service/api_request.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../core/data_source/remote/firebase/realtime_database/services/interface.dart';
import '../models/doctor_data.dart';
import '../../../core/data_source/remote/api_service/service/Api_constants.dart';
import '../../../core/data_source/remote/api_service/service/Lang_methods.dart';
import '../../../core/data_source/remote/api_service/service/request_model/headers.dart';
import '../../../core/data_source/remote/api_service/service/request_model/request_model.dart';
import '../../../core/helpers/data_types/make_appointment.dart';

class HomeDataSource{
  final ApiService _apiService;
  late final RealtimeServices _chat;
  HomeDataSource(this._apiService, this._chat);

  Future<AllDoctorsData> getHomeData()async{
    final homeResponse = await _apiService.callApi(
        request: RequestModel(
            method: Methods.GET,
            endPoint: ApiConstants.home,
            headers: HeadersWithToken()
        )
    );
    AllDoctorsData data = AllDoctorsData.fromJson(homeResponse.data);
    return data;
  }

  Future<DoctorsInSpecificField> showDoctorsBasedOnSpecialization(int specializationIndex)async{
    final response = await _apiService.callApi(
        request: RequestModel(
            method: Methods.GET,
            endPoint: ApiConstants.doctorsBasedOnSpecialization+specializationIndex.toString(),
            headers: HeadersWithToken()
        )
    );
    DoctorsInSpecificField data = DoctorsInSpecificField.fromJson(
        response.data['data']
    );
    return data;
  }

  Future<Response> storeAppointment({
    required MakeAppComponent model
  }) async{
    final storeAppointmentResponse = await _apiService.callApi(
        request: RequestModel(
            method: Methods.POST,
            endPoint: ApiConstants.makeAppointment,
            data: model.toJson(),
            headers: HeadersWithToken()
        )
    );

    return storeAppointmentResponse;
  }

  Future<String> giveRate({
    required int doctorId,
    required double rating
  }) async{
    Future.delayed(const Duration(seconds: 1)); // simulation
    return 'Thank you for rating!';

  }

  Future<String> sendMessageToDoctor({
    required String message,
    required int receiverId
  })async{
    return _chat.sendMessage(message: message, receiverId: receiverId);
  }

  Stream<DatabaseEvent> getMessages(int receiverId){
    return _chat.getMessages(receiverId);
  }

  Future<List<int>> getDoctorsIdsWhichUserChatWith()async{
    return _chat.getPeopleIdsWhichUserChatWith();
  }

  Future<DoctorInfo> getDoctorsDataBasedOnChats(int doctorId)async{
    final doctorData = await _apiService.callApi(
        request: RequestModel(
            method: Methods.GET,
            endPoint: ApiConstants.showDoctorBasedId + doctorId.toString(),
            headers: HeadersWithToken()
        )
    );
    DoctorInfo doctorInfo = DoctorInfo.fromJson(doctorData.data['data']);
    return doctorInfo;
  }

  Future<List<DoctorInfo>> getDoctorsChatsData()async{
    List<DoctorInfo> doctors = [];
    final List<int> doctorsIds = await getDoctorsIdsWhichUserChatWith();
    for (int doctorId in doctorsIds) {
      final doctorData = await getDoctorsDataBasedOnChats(doctorId);
      doctors.add(doctorData);
    }
    return doctors;
  }
}