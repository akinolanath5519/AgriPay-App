import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedDecimalPlaces = 2; // Default number of decimal places

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Decimal Places:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DropdownButton<int>(
              value: _selectedDecimalPlaces,
              onChanged: (value) {
                setState(() {
                  _selectedDecimalPlaces = value!;
                });
              },
              items: List.generate(
                15,
                (index) => DropdownMenuItem<int>(
                  value: index,
                  child: Text(
                    index.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Save the selected decimal places to persistent storage or use it in your app logic
          // For demonstration purposes, I'm just printing the selected value
          print('Selected Decimal Places: $_selectedDecimalPlaces');
          Navigator.pop(context, _selectedDecimalPlaces); // Pass the selected value back to the previous screen
        },
        label: const Text(
          'Save Settings',
          style: TextStyle(fontSize: 16),
        ),
        icon: const Icon(Icons.save),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
