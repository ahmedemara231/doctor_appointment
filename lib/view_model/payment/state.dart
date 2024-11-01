part of 'cubit.dart';

enum PaymentStates {
  stripeInitial,
  makePaymentProcessLoading,
  getClientSecret,
  makeStripeProcessSuccess,
  makeStripeProcessError,
  makePaypalProcessSuccess,
  makePaypalProcessError,
  setPaymentMethod,
}
enum PaymentMethods {stripe, paypal}
class PaymentState extends Equatable {

  PaymentStates? currentState;

  PaymentMethods? paymentMethod;
  String? clientSecret;
  String? errorMsg;
  PaymentState({
    this.currentState,
    this.paymentMethod,
    this.clientSecret,
    this.errorMsg,
  });

  factory PaymentState.initial(){
    return PaymentState(
      currentState : PaymentStates.stripeInitial,
      paymentMethod : PaymentMethods.stripe,
      clientSecret : '',
      errorMsg : '',
    );
  }

  PaymentState copyWith({
    required PaymentStates state,
    PaymentMethods? paymentMethod,
    dynamic clientSecret,
    String? errorMessage,
  })
  {
    return PaymentState(
        currentState: state,
        paymentMethod: paymentMethod?? this.paymentMethod,
        clientSecret: clientSecret?? this.clientSecret,
        errorMsg: errorMessage?? errorMsg,
    );
  }

  @override
  List<Object?> get props => [
    currentState,
    paymentMethod,
    clientSecret,
    errorMsg,
  ];
}