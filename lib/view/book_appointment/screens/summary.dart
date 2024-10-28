import 'package:flutter/material.dart';

import '../../../helpers/base_widgets/text.dart';

class Summary extends StatelessWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyText(text: 'Summary Page'),
    );
  }
}
