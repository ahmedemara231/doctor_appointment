class AmountModel
{
  String total;
  String currency;

  AmountModel({
    required this.total,
    this.currency = 'USD',
  });

  Map<String,dynamic> toJson()
  {
    return {
        'total' : total,
        'currency' : currency,
      };
  }
}