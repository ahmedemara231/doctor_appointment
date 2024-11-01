part of 'stripe_cubit.dart';

enum StripeStates {
  stripeInitial,
  makePaymentProcessLoading,
  getClientSecret,
  makePaymentProcessSuccess,
  makePaymentProcessError
}
class StripeState extends Equatable {

  StripeStates? currentState;
  String? clientSecret;
  String? errorMsg;
  StripeState({
    this.currentState,
    this.clientSecret,
    this.errorMsg,
  });

  factory StripeState.initial(){
    return StripeState(
      currentState : StripeStates.stripeInitial,
      clientSecret : '',
      errorMsg : '',
    );
  }

  StripeState copyWith({
    required StripeStates state,
    dynamic clientSecret,
    String? errorMessage,
  })
  {
    return StripeState(
        currentState: state,
        clientSecret: clientSecret?? this.clientSecret,
        errorMsg: errorMessage?? errorMsg,
    );
  }

  @override
  List<Object?> get props => [
    currentState,
    clientSecret,
    errorMsg,
  ];
}