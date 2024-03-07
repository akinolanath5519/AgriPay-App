import 'package:flutter/material.dart';
import 'package:jolmonak/login_form_screen/login_page.dart'; // Import the login page file

class ExpiryDateSelectionScreen extends StatefulWidget {
  const ExpiryDateSelectionScreen({Key? key}) : super(key: key);
  @override
  _ExpiryDateSelectionScreenState createState() =>
      _ExpiryDateSelectionScreenState();
}

class _ExpiryDateSelectionScreenState
    extends State<ExpiryDateSelectionScreen> {
  String _password = '';
  DateTime? _selectedDate;

  void _setExpiryDate(BuildContext context) async {
    // Hardcoded username and password
    if (_password == 'password') {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.green, // Head background // Popup background
              colorScheme: const ColorScheme.light(primary: Colors.green),
              buttonTheme: const ButtonThemeData(
                textTheme: ButtonTextTheme.primary,
                buttonColor: Colors.green, // OK/Cancel button background color
              ),
            ),
            child: child!,
          );
        },
      );
      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedDate = picked;
        });
        // Navigate to the login page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPage(expiryDate: _selectedDate!)),
        );
      }
    } else {
      // Show password error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Incorrect password. Please try again.',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 178, 32),
        title: const Center(
          child: Text(
            'Expiry Date',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                _password = value;
              },
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Enter password',
                labelStyle: TextStyle(fontSize: 30),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _selectedDate != null
                  ? null
                  : () => _setExpiryDate(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the border radius as needed
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
              ),
              child: const Text(
                'Set Expiry Date',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_selectedDate != null)
              Text(
                'Expiry Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
