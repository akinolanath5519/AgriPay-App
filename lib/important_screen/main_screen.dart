import 'package:flutter/material.dart';
import 'package:jolmonak/important_screen/calculator_screen.dart';
import 'package:jolmonak/important_screen/bulk_weight_screen.dart';
import 'package:jolmonak/important_screen/purchases_screen.dart';
import 'package:jolmonak/important_screen/sales_screen.dart';
import 'package:jolmonak/important_screen/supplier_screen.dart';
import 'package:jolmonak/important_screen/users_screen.dart';
import 'package:jolmonak/important_screen/commodities_screen.dart';
import 'package:jolmonak/important_screen/settings_screen.dart';

class MainScreen extends StatelessWidget {
  final int decimalPlaces; // Add decimalPlaces argument // Add AuthService instance
  const MainScreen({Key? key, required this.decimalPlaces}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Main Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16, // Add spacing between each screen
        mainAxisSpacing: 16, // Add spacing between each row
        padding: const EdgeInsets.all(16), // Add padding around the GridView
        children: <Widget>[
          _buildScreenItem(
              context, CalculatorScreen(decimalPlaces: decimalPlaces), Icons.calculate, 'Calculator'),
          _buildScreenItem(context, const CommoditiesScreen(),
              Icons.shopping_cart, 'Commodities'),
          _buildScreenItem(context, const PurchasesScreen(), Icons.attach_money,
              'Purchases'),
          _buildScreenItem(
              context, const BulkWeightScreen(), Icons.settings, 'Bulk Weight'),
          _buildScreenItem(context, const UsersScreen(), Icons.people, 'Users'), // Pass the authService to UsersScreen
          _buildScreenItem(
              context, const SalesScreen(), Icons.local_mall, 'Sales'),
          _buildScreenItem(context, const SupplierScreen(),
              Icons.supervisor_account, 'Suppliers'),
          // Add the settings screen item
          _buildScreenItem(
              context, const SettingsScreen(), Icons.settings, 'Settings'),
        ],
      ),
    );
  }

  Widget _buildScreenItem(
      BuildContext context, Widget screen, IconData iconData, String label) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                _buildDestinationScreen(context, screen, label),
          ),
        );
      },
      splashColor:
          Colors.blue, // Change splash color to blue for better visibility
      child: Hero(
        tag: label, // Unique tag for each Hero widget
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300), // Animation duration
          curve: Curves.easeInOut, // Animation curve
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 64,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDestinationScreen(
      BuildContext context, Widget screen, String label) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 178, 32),
        title: 
           Text(
            label,
            style: const TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize:24),
          ),
        ), // Use the label as the title
      body: screen, // Display the destination screen
    );
  }
}
