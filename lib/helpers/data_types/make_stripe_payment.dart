import '../../model/remote/stripe/models/intent_request_model.dart';

class MakeStripePaymentSuccess{
  IntentRequestModel model;
  String ephemeralKey;

  MakeStripePaymentSuccess({required this.model, required this.ephemeralKey});
}