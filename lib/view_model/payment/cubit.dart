import 'package:bloc/bloc.dart';
import 'package:doctors_appointment/model/local/secure.dart';
import 'package:doctors_appointment/model/remote/paypal/service.dart';
import 'package:doctors_appointment/model/remote/stripe/repos/post.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../helpers/data_types/appointment_details.dart';
import '../../model/remote/stripe/models/payment_intent_model.dart';
part 'state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.repo) : super(PaymentState.initial());
  StripePostRepo repo;

  Future<void> initPaymentSheet({
    required String paymentIntentClientSecret,
    required String ephemeralKey,
    required String? customerId,
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
        customerId: customerId,
        customerEphemeralKeySecret: ephemeralKey, // has customer id
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
    final payResponse = await repo.makeStripePayment(inputModel: model);
    payResponse.when(
            (success) async{
              await initPaymentSheet(
                  paymentIntentClientSecret: payResponse.getOrThrow().model.client_secret!,
                  ephemeralKey: payResponse.getOrThrow().ephemeralKey,
                  customerId: model.customerId
              );
              await presentPaymentSheet();

              emit(
                  state.copyWith(
                    state: PaymentStates.makePaymentProcessSuccess,
                  )
              );
            },
            (error) {
              emit(
                  state.copyWith(
                    state: PaymentStates.makePaymentProcessError,
                  )
              );
            }
    );
  }

  Future<void> makePaypalPaymentProcess(BuildContext context, {
    required int amount,
    required UserAppointmentDetails details
  })async{
    await PaypalService().makePaypalPaymentProcess(
      context,
      amount: amount,
      details: details
    );
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
  Future<void> pay(BuildContext context, {
    required int amount,
    required UserAppointmentDetails details
  })async{
    switch(state.paymentMethod){
      case PaymentMethods.stripe:
        await makeStripePaymentProcess(
            model: CreateIntentInputModel(
                amount: (amount * 100).toString(),
                currency: 'USD',
                customerId: await SecureStorage.getInstance().readData(key: 'customerId') as String
            )
        );

      default:
        await makePaypalPaymentProcess(
            context,
            amount: amount * 100,
            details: details
        );
    }
  }
}
