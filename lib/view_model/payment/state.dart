part of 'cubit.dart';

enum PaymentStates {
  stripeInitial,
  makePaymentProcessLoading,
  makePaymentProcessSuccess,
  makePaymentProcessError,
  setPaymentMethod,
}
enum PaymentMethods {stripe, paypal}
class PaymentState extends Equatable {

  PaymentStates? currentState;

  PaymentMethods? paymentMethod;
  String? errorMsg;
  PaymentState({
    this.currentState,
    this.paymentMethod,
    this.errorMsg,
  });

  factory PaymentState.initial(){
    return PaymentState(
      currentState : PaymentStates.stripeInitial,
      paymentMethod : PaymentMethods.stripe,
      errorMsg : '',
    );
  }

  PaymentState copyWith({
    required PaymentStates state,
    PaymentMethods? paymentMethod,
    String? errorMessage,
  })
  {
    return PaymentState(
        currentState: state,
        paymentMethod: paymentMethod?? this.paymentMethod,
        errorMsg: errorMessage?? errorMsg,
    );
  }

  @override
  List<Object?> get props => [
    currentState,
    paymentMethod,
    errorMsg,
  ];
}