import 'package:flutter/material.dart';
import 'package:rating_summary/rating_summary.dart';

class Rating extends StatelessWidget {
  const Rating({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RatingSummary(
          counter: 13,
          average: 4,
          showAverage: true,
          counterFiveStars: 5,
          counterFourStars: 4,
          counterThreeStars: 2,
          counterTwoStars: 1,
          counterOneStars: 1,
        ),
      ],
    );
  }
}
