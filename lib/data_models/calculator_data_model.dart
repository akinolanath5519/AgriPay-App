import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Transaction {
  String id;
  double quantity;
  double price;
  DateTime date;
  TimeOfDay time;
  String unit;
  double rate;

  Transaction({
    required this.id,
    required this.quantity,
    required this.price,
    required this.date,
    required this.time,
    required this.unit,
    required this.rate,
  });
}

// Function to generate a unique ID using the uuid package
String generateUniqueId() {
  var uuid = const Uuid();
  return uuid.v4(); // Generates a version 4 (random) UUID
}
