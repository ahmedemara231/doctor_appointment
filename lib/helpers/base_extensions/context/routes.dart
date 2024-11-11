import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

extension Routes on BuildContext
{
  Future normalNewRoute(Widget newRoute, {PageTransitionType? type})async {
    if(type != null){
      return await Navigator.push(
        this,
        PageTransition(
          type: type,
          child: newRoute,
        ),
      );
    }
    return await Navigator.push(
        this,
        MaterialPageRoute(
            builder: (context) => newRoute,
        ),
    );
  }

  Future removeOldRoute(Widget newRoute, {PageTransitionType? type})async {
    if(type != null){
      return await Navigator.pushAndRemoveUntil(
        this,
        PageTransition(
          type: type,
          child: newRoute,
        ), (route) => false,
      );
    }
    return Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(
          builder: (context) => newRoute,
        ), (route) => false,
    );
  }

  Future replacementRoute(Widget newRoute, {PageTransitionType? type})async {
    if(type != null){
      return await Navigator.pushReplacement(
        this,
        PageTransition(
          type: type,
          child: newRoute,
        ),
      );
    }
    return await Navigator.pushReplacement(
      this,
      MaterialPageRoute(
        builder: (context) => newRoute,
      ),
    );
  }
}