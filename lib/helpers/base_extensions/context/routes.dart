import 'package:flutter/material.dart';

extension Routes on BuildContext
{
  Future normalNewRoute(Widget newRoute)async {
    await Navigator.push(
        this,
        MaterialPageRoute(
            builder: (context) => newRoute,
        ),
    );
  }

  Future removeOldRoute(Widget newRoute)async {
    Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(
          builder: (context) => newRoute,
        ), (route) => false,
    );
  }

  Future replacementRoute(Widget newRoute)async {
    await Navigator.pushReplacement(
      this,
      MaterialPageRoute(
        builder: (context) => newRoute,
      ),
    );
  }
}