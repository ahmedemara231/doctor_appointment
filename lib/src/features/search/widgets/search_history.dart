import 'package:doctors_appointment/src/core/helpers/base_widgets/text.dart';
import 'package:flutter/material.dart';

class SearchHistory extends StatelessWidget {
  const SearchHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.timelapse_outlined, color: Colors.grey[400],),
      title: MyText(text: 'Doctor Name', color: Colors.grey[400]),
      trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.close, color: Colors.grey[400],)
      ),
    );
  }
}
