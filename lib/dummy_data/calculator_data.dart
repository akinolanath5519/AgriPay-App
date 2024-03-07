import 'package:flutter/material.dart';
import 'package:jolmonak/data_models/calculator_data_model.dart';
import 'package:uuid/uuid.dart';

Transaction calculation = Transaction(
  id: const Uuid().v4(), // Generate a UUID for the calculation ID
  quantity: 5.0,
  price: 10.0,
  rate:50000 ,
  date: DateTime.now(),
  time: TimeOfDay.now(),
  unit: 'Metric tonne', // Provide a value for the unit field
);
