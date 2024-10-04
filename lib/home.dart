import 'package:flutter/material.dart';

class ATMHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ATM Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButton(
              'Check Balance',
              Icons.account_balance_wallet,
              () => _navigateToPage(context, 'Check Balance'),
            ),
            _buildButton(
              'Withdraw',
              Icons.money_off,
              () => _navigateToPage(context, 'Withdraw'),
            ),
            _buildButton(
              'Pay Bills',
              Icons.payment,
              () => _navigateToPage(context, 'Pay Bills'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, Function onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: IconButton(
        onPressed: () => onTap(),
        icon: Icon(icon),
        tooltip: text,
      ),
    );
  }

  void _navigateToPage(BuildContext context, String pageName) {
    // Implement navigation logic to the respective pages
    // For example:
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => CheckBalancePage()),
    // );
    // Replace CheckBalancePage with the actual page widget for each feature
  }
}
