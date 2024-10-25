import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../helpers/base_widgets/text.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
          onPressed: () =>
              context.setLocale(const Locale('ar')),
          child: MyText(text: 'Change')
      ),
    );
  }
}
