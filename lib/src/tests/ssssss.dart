import 'package:flutter/material.dart';

class BottomSheetExample extends StatefulWidget {
  @override
  _BottomSheetExampleState createState() => _BottomSheetExampleState();
}

class _BottomSheetExampleState extends State<BottomSheetExample> {
  bool isBottomSheetOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bottom Sheet Example')),
      body: Stack(
        children: [
          // Main content of the screen
          Center(
            child: ElevatedButton(
              onPressed: () {
                _showBottomSheet();
              },
              child: Text("Open Bottom Sheet"),
            ),
          ),

          // Semi-transparent overlay when the bottom sheet is open
          // if (isBottomSheetOpen)
          //   Positioned.fill(
          //     child: GestureDetector(
          //       onTap: () {
          //         Navigator.of(context).pop(); // Close the bottom sheet when tapping the overlay
          //       },
          //       child: Container(
          //         color: Colors.black.withOpacity(0.5), // Dark overlay
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }

  void _showBottomSheet() {
    setState(() {
      isBottomSheetOpen = true;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            setState(() {
              isBottomSheetOpen = false;
            });
            return true;
          },
          child: Container(
            padding: EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              children: [
                Text(
                  "This is the Bottom Sheet",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isBottomSheetOpen = false;
                    });
                    Navigator.of(context).pop(); // Close the bottom sheet
                  },
                  child: Text("Close"),
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() {
      setState(() {
        isBottomSheetOpen = false;
      });
    });
  }
}
