import 'package:dio/src/response.dart';
import 'package:doctors_appointment/model/remote/stripe/models/intent_request_model.dart';
import 'package:multiple_result/src/result.dart';
import '../../../local/secure.dart';
import '../../api_service/service/Lang_methods.dart';
import '../../api_service/service/api_request.dart';
import '../../api_service/service/error_handling/errors.dart';
import '../../api_service/service/request_model/request_model.dart';
import '../models/payment_intent_model.dart';
import '../service/request_model/headers.dart';
import '../service/stripe_constants.dart';

class StripePostRepo {
  late ApiService apiService;

  StripePostRepo({required this.apiService});

  // create payment intent
  Future<Result<IntentRequestModel, CustomError>> createPaymentIntent({required CreateIntentInputModel inputModel}) async {
    Result<Response, CustomError> createIntentResponse =
    await apiService.callApi(
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

    if (createIntentResponse.isSuccess()) {
      IntentRequestModel model =
      IntentRequestModel.fromJson(createIntentResponse.getOrThrow().data);
      return Result.success(model);
    } else {
      return Result.error(createIntentResponse.tryGetError()!);
    }
  }

  // create customer
  Future<Result<String, CustomError>> createCustomer({
    required String name,
  }) async {
    Result<Response, CustomError> createCustomerResponse =
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

    return createCustomerResponse.when(
          (success) => Result.success(success.data['id']),
          (error) => Result.error(error),
    );
  }

  // create  Ephemeral Key
  Future<Result<String, CustomError>> createEphemeralKey() async {
    Result<Response, CustomError> createEphemeralKeyResponse =
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

    return createEphemeralKeyResponse.when(
          (success) => Result.success(success.data['secret']),
          (error) => Result.error(error),
    );
  }
}
