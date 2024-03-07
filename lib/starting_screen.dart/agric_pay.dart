import 'package:flutter/material.dart';
import 'package:jolmonak/starting_screen.dart/expiry_date_screen.dart';


class AgripayApp extends StatelessWidget {
const AgripayApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    (MediaQuery.of(context).size.width);
    (MediaQuery.of(context).size.width);

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: const ExpiryDateSelectionScreen(),
    );
  }
}