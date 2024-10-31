part of 'stripe_cubit.dart';

enum States {
  stripeInitial,
  makePaymentProcessLoading,
  getClientSecret,
  makePaymentProcessSuccess,
  makePaymentProcessError
}
class StripeState extends Equatable {

  States? currentState;
  String? clientSecret;
  String? errorMsg;
  StripeState({
    this.currentState,
    this.clientSecret,
    this.errorMsg,
  });

  factory StripeState.initial(){
    return StripeState(
      currentState : States.stripeInitial,
      clientSecret : '',
      errorMsg : '',
    );
  }

  StripeState copyWith({
    required States state,
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