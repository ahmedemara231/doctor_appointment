import 'package:dio/src/response.dart';
import 'package:multiple_result/src/result.dart';
import '../../../../helpers/data_types/make_stripe_payment.dart';
import '../../../local/secure.dart';
import '../../api_service/service/Lang_methods.dart';
import '../../api_service/service/api_request.dart';
import '../../api_service/service/error_handling/base_remote_error_class.dart';
import '../../api_service/service/request_model/request_model.dart';
import '../models/intent_request_model.dart';
import '../models/payment_intent_model.dart';
import '../service/request_model/headers.dart';
import '../service/stripe_constants.dart';

class StripePostRepo {
  late ApiService apiService;
  StripePostRepo({required this.apiService});

  // create payment intent
  Future<IntentRequestModel> createPaymentIntent({required CreateIntentInputModel inputModel}) async {
      Response createIntentResponse = await apiService.callApi(
        request: RequestModel(
          method: Methods.POST,
          endPoint: StripeConstants.createIntent,
          data: {
            'amount': inputModel.amount,
            'currency': inputModel.currency,
            'customer': inputModel.customerId,
          },
          headers: StripeHeaders(contentType: 'application/x-www-form-urlencoded'),
        ),
      );

      IntentRequestModel model =
      IntentRequestModel.fromJson(createIntentResponse.data);
      return model;
  }

  // create customer
  Future<String> createCustomer({
    required String name,
  }) async {
      Response createCustomerResponse =
      await apiService.callApi(
        request: RequestModel(
          method: Methods.POST,
          endPoint: StripeConstants.createCustomer,
          data: {
            'name': name,
          },
          headers:
          StripeHeaders(contentType: 'application/x-www-form-urlencoded'),
        ),
      );

      return createCustomerResponse.data['id'];
  }

  // create  Ephemeral Key
  Future<String> createEphemeralKey() async {
      Response createEphemeralKeyResponse =
      await apiService.callApi(
        request: RequestModel(
          method: Methods.POST,
          endPoint: StripeConstants.getEphemeralKey,
          data: {
            'customer' : await SecureStorage.getInstance().readData(key: 'customerId')
          },
          headers:
          StripeHeaders(
              contentType: 'application/x-www-form-urlencoded',
              stripeVersion: '2024-06-20'
          ),
        ),
      );

      return createEphemeralKeyResponse.data['secret'];
  }

  Future<Result<MakeStripePaymentSuccess, RemoteError>> makeStripePayment({
    required CreateIntentInputModel inputModel
})async{
    try{
      final intentResponse = await createPaymentIntent(inputModel: inputModel);
      final ephemeralKeyResponse = await createEphemeralKey();
      return Result.success(
          MakeStripePaymentSuccess(
              model: intentResponse,
              ephemeralKey: ephemeralKeyResponse
          )
      );
    }catch(e){
      return Result.error(RemoteError(e.toString()));
    }
  }
}
