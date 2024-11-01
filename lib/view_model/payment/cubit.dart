import 'package:bloc/bloc.dart';
import 'package:doctors_appointment/model/local/secure.dart';
import 'package:doctors_appointment/model/remote/paypal/service.dart';
import 'package:doctors_appointment/model/remote/stripe/repos/post.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../model/remote/stripe/models/payment_intent_model.dart';
part 'state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.repo) : super(PaymentState.initial());
  StripePostRepo repo;


  Future<String> createEphemeralKey()async
  {
    final key = await repo.createEphemeralKey();
    return key.getOrThrow();
  }

  Future<void> createPaymentIntent(CreateIntentInputModel model)async{
      final resultOfRequestingCreatePaymentIntent = await repo.createPaymentIntent(
        inputModel: model // جواه cus id
    );
    emit(state.copyWith(
        state: PaymentStates.getClientSecret,
        clientSecret: resultOfRequestingCreatePaymentIntent.getOrThrow().client_secret
    ));
  }

  Future<void> initPaymentSheet({
    required String paymentIntentClientSecret,
    // required String customerId
  }) async {

    // 2. initialize the payment sheet
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(

        // Set to true for custom flow
        // customFlow: false,

        // Main params
        merchantDisplayName: 'MediMeet',
        paymentIntentClientSecret: paymentIntentClientSecret,

        // Customer keys
        customerId:  await SecureStorage.getInstance().readData(key: 'customerId')?? '',
        customerEphemeralKeySecret: await createEphemeralKey(), // has customer id
      ),
    );
  }

  Future<void> presentPaymentSheet()async
  {
    await Stripe.instance.presentPaymentSheet();
  }

  Future<void> makeStripePaymentProcess({
    required CreateIntentInputModel model,
})async
  {
    emit(state.copyWith(state: PaymentStates.makePaymentProcessLoading));

    await createPaymentIntent(model);
    await initPaymentSheet(
      paymentIntentClientSecret: state.clientSecret!
    );
    await presentPaymentSheet();
    
    emit(state.copyWith(state: PaymentStates.makeStripeProcessSuccess));
  }
  Future<void> makePaypalPaymentProcess(BuildContext context, {required int amount})async{
    await PaypalService().makePaypalPaymentProcess(context, amount: amount);
  }

  void setPaymentMethod(String payMethod){
    late PaymentMethods method;
    switch(payMethod){
      case 'PayPal':
        method = PaymentMethods.paypal;

      default:
        method = PaymentMethods.stripe;
    }

    emit(state.copyWith(
        state: PaymentStates.setPaymentMethod,
        paymentMethod: method
    ));
  }
  Future<void> pay(BuildContext context)async{
    const int amount = 100*100;
    switch(state.paymentMethod){
      case PaymentMethods.stripe:
        await makeStripePaymentProcess(
            model: CreateIntentInputModel(
                amount: amount.toString(),
                currency: 'USD',
                customerId: await SecureStorage.getInstance().readData(key: 'customerId') as String
            )
        );

      default:
        await makePaypalPaymentProcess(context, amount: amount);
    }
  }
}
