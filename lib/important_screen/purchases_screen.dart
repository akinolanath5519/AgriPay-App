import 'package:flutter/material.dart';
import 'package:jolmonak/providers/calculation_providers.dart';
import 'package:provider/provider.dart';

class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back navigation button
        title: const Text('Purchase History'), // Set app bar title
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, transactionProvider, child) {
          final transactions = transactionProvider.transactions;
          // Calculate total number of transactions
          int totalTransactions = transactions.length;

          // Calculate total price of all transactions
          double totalPrice = 0;
          transactions.forEach((transaction) {
            totalPrice += transaction.price;
          });

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return ListTile(
                      title: Text(
                        'Transaction ID: ${transaction.id}',
                        style: const TextStyle(fontSize: 18), // Increase font size
                      ),
                      subtitle: Text(
                        'Quantity: ${transaction.quantity}, Price: ${transaction.price}',
                        style: const TextStyle(fontSize: 16), // Increase font size
                      ),
                      // Add more details of the transaction as needed
                    );
                  },
                ),
              ),
              // Display total number of transactions and total price
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Transactions: $totalTransactions',
                      style: const TextStyle(fontSize: 20), // Increase font size
                    ),
                    Text(
                      'Total Price: ₦${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 20), // Increase font size
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
