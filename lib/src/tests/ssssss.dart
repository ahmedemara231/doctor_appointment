import 'package:flutter/material.dart';

class MyCustomSearchDelegate extends StatelessWidget {
  const MyCustomSearchDelegate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios_rounded),
        title: TextField(
          decoration: InputDecoration(),
        ),
        actions: [
          const Icon(Icons.close),

        ],
      ),
    );
  }
}
