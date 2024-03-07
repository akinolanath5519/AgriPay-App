import 'package:flutter/material.dart';

class ReceiptScreen extends StatelessWidget {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final double? quantity;
  final double? price;

  const ReceiptScreen({
    Key? key,
    required this.selectedDate,
    required this.selectedTime,
    required this.quantity,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              _printReceipt(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Receipt Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (selectedDate != null && selectedTime != null)
              Text(
                'Date: ${_formatDate(selectedDate!)} ${_formatTime(selectedTime!)}',
                style: const TextStyle(fontSize: 16),
              ),
            if (quantity != null)
              Text(
                'Quantity: ${quantity.toString()} kg',
                style: const TextStyle(fontSize: 16),
              ),
            if (price != null)
              Text(
                'Price: ₦${price!.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  void _printReceipt(BuildContext context) {
    // Implement your printing logic here
    // For example, you can use a printing package or invoke native printing APIs
    // You can also show a dialog or a toast message to indicate that the receipt is being printed
    // For demonstration purposes, let's just print a message to the console
    print('Printing receipt...');
  }
}
