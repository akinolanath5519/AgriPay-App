import 'package:flutter/material.dart';
import 'package:jolmonak/data_models/calculator_data_model.dart'; // Import your Transaction data model

class TransactionProvider extends ChangeNotifier {
 final  List<Transaction> _transactions = []; // List to store transactions

  // Method to add a new transaction
  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners(); // Notify listeners (e.g., widgets) that the data has changed
  }

  // Getter method to retrieve the list of transactions
  List<Transaction> get transactions => _transactions;
}
