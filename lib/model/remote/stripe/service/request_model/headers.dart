import 'dart:io';

import '../../../api_service/service/request_model/headers.dart';
import '../stripe_constants.dart';

class StripeHeaders extends RequestHeaders
{
  final stripeVersion;

  StripeHeaders({required super.contentType,this.stripeVersion});

  Map<String,dynamic> get _getHeaders
  {
    return
      {
        HttpHeaders.authorizationHeader : StripeConstants.tokenSecretKey,
        HttpHeaders.contentTypeHeader : contentType,
        'Stripe-Version' : stripeVersion,
      };
  }

  @override
  Future<Map<String, dynamic>> toJson()async {
    return _getHeaders;
  }
}