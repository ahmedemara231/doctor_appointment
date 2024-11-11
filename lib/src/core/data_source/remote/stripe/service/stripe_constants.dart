class StripeConstants{
  // keys
  static const String tokenSecretKey = 'Bearer sk_test_51QFdSjDZoacI0UcJVHVhmk0YmMvmtbQ9RUly13XyMvjL5v7tDHD0WSkAr2DXaGdWpt2xY8krnYDIkBJh0DAtp6ob002DJTbory';
  static const String publishableKey = 'pk_test_51QFdSjDZoacI0UcJCiV32X2Qfy3zA7Q2C08vfBnArnT0S5Bc9hTaP8Z1tVoIONvfMkfvORR0YhRsnf1haIqe59iR00ijoaFRnX';

  //base url
  static const String baseUrl = 'https://api.stripe.com/v1/';


  // end points
  static const String createIntent = 'payment_intents';
  static const String createCustomer = 'customers';
  static const String getEphemeralKey = 'ephemeral_keys';
}