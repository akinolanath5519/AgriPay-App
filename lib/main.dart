import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart'; // Make sure to import Provider package
import 'package:jolmonak/starting_screen.dart/agric_pay.dart';
import 'package:jolmonak/providers/calculation_providers.dart';

void main() {
  // Lock the device orientation to portrait-up mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(
      ChangeNotifierProvider(
        create: (context) => TransactionProvider(), // Provide an instance of TransactionProvider
        child: const AgripayApp(),
      ),
    );
  });
}
