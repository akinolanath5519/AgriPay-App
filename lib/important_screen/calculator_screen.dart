import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:jolmonak/important_screen/receipt_screen.dart';
import 'package:jolmonak/providers/calculation_providers.dart';
import 'package:jolmonak/data_models/calculator_data_model.dart';

class CalculatorScreen extends StatefulWidget {
  final int decimalPlaces; // Receive the selected number of decimal places
  const CalculatorScreen({Key? key, required this.decimalPlaces})
      : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String? _selectedUnit;
  double? _rate;
  double? _quantity;
  double? _price;
  late int
      _decimalPlaces; // Use late initialization to ensure it's initialized in initState
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _decimalPlaces = widget
        .decimalPlaces; // Initialize _decimalPlaces with the value passed from SettingsScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back navigation button
        title: const  Text(
            'Commodity Price Calculator',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
        ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enter quantity in kg',
                labelStyle: TextStyle(fontSize: 20),
                prefixIcon: Icon(Icons.input),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  // Parse the value to a double explicitly
                  _quantity = double.tryParse(value) ?? 0.0;
                });
                _calculatePrice();
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Unit: '),
                DropdownButton<String>(
                  value: _selectedUnit,
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'Metric tonne',
                      child: Row(
                        children: [
                          Icon(Icons.ac_unit),
                          SizedBox(width: 5),
                          Text('Metric tonne'),
                        ],
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Tare',
                      child: Row(
                        children: [
                          Icon(Icons.ac_unit),
                          SizedBox(width: 5),
                          Text('Tare'),
                        ],
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Polythene',
                      child: Row(
                        children: [
                          Icon(Icons.ac_unit),
                          SizedBox(width: 5),
                          Text('Polythene'),
                        ],
                      ),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Jute sack',
                      child: Row(
                        children: [
                          Icon(Icons.ac_unit),
                          SizedBox(width: 5),
                          Text('Jute sack'),
                        ],
                      ),
                    ),
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      _selectedUnit = value;
                    });
                    _calculatePrice();
                  },
                  hint: const Text('Select unit'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enter rate in naira',
                labelStyle: TextStyle(fontSize: 20),
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  // Parse the value to a double explicitly
                  _rate = double.tryParse(value) ?? 0.0;
                });
                _calculatePrice();
              },
            ),
            const SizedBox(height: 20),
            if (_price != null)
              Column(
                children: [
                  Text(
                    'Price: ${_formatPrice(_price!)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Price in words: ${_convertToWords(_price!)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            DateTimeDisplay(
              onDateSelected: (DateTime selectedDate) {
                setState(() {
                  _selectedDate = selectedDate;
                });
              },
              onTimeSelected: (TimeOfDay selectedTime) {
                setState(() {
                  _selectedTime = selectedTime;
                });
              },
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Access the transaction provider
                final transactionProvider =
                    Provider.of<TransactionProvider>(context, listen: false);
                // Add the transaction
                transactionProvider.addTransaction(
                  Transaction(
                    id: generateUniqueId(),
                    quantity: _quantity ?? 0.0,
                    price: _price ?? 0.0,
                    date: _selectedDate ?? DateTime.now(),
                    time: _selectedTime ?? TimeOfDay.now(),
                    unit: _selectedUnit ?? '',
                    rate: _rate ?? 0.0,
                  ),
                );
                // Show a confirmation message or update the UI as needed
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Transaction added successfully')),
                );
                // Navigate to the receipt screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReceiptScreen(
                      selectedDate: _selectedDate,
                      selectedTime: _selectedTime,
                      quantity: _quantity,
                      price: _price,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 13, horizontal: 24), // Increase padding
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'View Receipts',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _calculatePrice() {
    if (_quantity != null && _rate != null && _selectedUnit != null) {
      setState(() {
        switch (_selectedUnit) {
          case 'Metric tonne':
            _price = _quantity! / 1000 * _rate!;
            break;
          case 'Tare':
            _price = _quantity! / 1014 * _rate!;
            break;
          case 'Polythene':
            _price = _quantity! / 1027 * _rate!;
            break;
          case 'Jute sack':
            _price = _quantity! / 1040 * _rate!;
            break;
          default:
            _price = null;
            break;
        }
      });
    } else {
      setState(() {
        _price = null;
      });
    }
  }

  String _formatPrice(double price) {
    return NumberFormat.currency(
      locale: 'en_US',
      symbol: '₦',
    ).format(price);
  }

  String _convertToWords(double price) {
    // Custom logic to convert numeric price to words
    // Implement your own logic here or use a library
    // This is a basic example, you might need a more robust solution
    // Adapted from: https://stackoverflow.com/a/55276564
    final numberWords = <int, String>{
      0: 'zero',
      1: 'one',
      2: 'two',
      3: 'three',
      4: 'four',
      5: 'five',
      6: 'six',
      7: 'seven',
      8: 'eight',
      9: 'nine',
      10: 'ten',
      11: 'eleven',
      12: 'twelve',
      13: 'thirteen',
      14: 'fourteen',
      15: 'fifteen',
      16: 'sixteen',
      17: 'seventeen',
      18: 'eighteen',
      19: 'nineteen',
      20: 'twenty',
      30: 'thirty',
      40: 'forty',
      50: 'fifty',
      60: 'sixty',
      70: 'seventy',
      80: 'eighty',
      90: 'ninety',
    };

    final num = price.toInt();

    if (num < 20) {
      return numberWords[num]!;
    } else if (num < 100) {
      return '${numberWords[num ~/ 10 * 10]} ${numberWords[num % 10]}';
    } else if (num < 1000) {
      return '${numberWords[num ~/ 100]} hundred ${_convertToWords(num % 100)}';
    } else if (num < 1000000) {
      return '${_convertToWords((num ~/ 1000).toDouble())} thousand ${_convertToWords(num % 1000)}';
    } else if (num < 1000000000) {
      return '${_convertToWords((num ~/ 1000000).toDouble())} million ${_convertToWords(num % 1000000)}';
    } else {
      return 'number too large';
    }
  }
}

class DateTimeDisplay extends StatelessWidget {
  final Function(DateTime) onDateSelected;
  final Function(TimeOfDay) onTimeSelected;

  const DateTimeDisplay({
    required this.onDateSelected,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => _pickDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Date',
                  style: TextStyle(fontSize: 16),
                ),
                Icon(Icons.calendar_today),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () => _pickTime(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Time',
                  style: TextStyle(fontSize: 16),
                ),
                Icon(Icons.access_time),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      onDateSelected(pickedDate);
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      onTimeSelected(pickedTime);
    }
  }
}
