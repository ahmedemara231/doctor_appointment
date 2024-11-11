class AmountModel
{
  final String total;
  final String currency;
  final Details? details;

  AmountModel({
    required this.total,
    this.currency = 'USD',
    this.details,
  });

  Map<String,dynamic> toJson()
  {
    return {
      'total' : total,
      'currency' : currency,
      'details' : details!.toJson(),
    };
  }
}

class Details {
  final String subtotal;
  final String? shipping;
  final int? shippingDiscount;

  Details({
    required this.subtotal,
    this.shipping,
    this.shippingDiscount,
  });

  Map<String, dynamic> toJson(){
    return {
     'subtotal': subtotal,
     'shipping': shipping?? "0",
     'shipping_discount': shippingDiscount?? 0
    };
  }
}