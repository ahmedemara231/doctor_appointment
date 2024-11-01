import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:doctors_appointment/model/local/secure.dart';
import 'package:doctors_appointment/model/local/shared.dart';
import 'package:doctors_appointment/model/remote/stripe/repos/post.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../model/remote/stripe/models/payment_intent_model.dart';
part 'stripe_state.dart';


class StripeCubit extends Cubit<StripeState> {
  StripeCubit(this.repo) : super(StripeState.initial());
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
        state: StripeStates.getClientSecret,
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

  Future<void> makePaymentProcess({
    required CreateIntentInputModel model,
})async
  {
    emit(state.copyWith(state: StripeStates.makePaymentProcessLoading));

    await createPaymentIntent(model);
    await initPaymentSheet(
      paymentIntentClientSecret: state.clientSecret!
    );
    await presentPaymentSheet();
    
    emit(state.copyWith(state: StripeStates.makePaymentProcessSuccess));
  }
}
