import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'main.dart'; // Import the main.dart file to access the ATM class

class HomeScreen extends StatefulWidget {
  final ATM atm;
  const HomeScreen({Key? key, required this.atm}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ATM _atm;
  late double _currentBalance = 100.0;

  get atmInstance => null;

  @override
  void initState() {
    super.initState();
    _atm = widget.atm;
    _currentBalance = _atm.balance;
  }

  void _deposit(double amount) {
    setState(() {
      _atm.deposit(amount);
      _currentBalance = _atm.balance;
    });
  }

  void _withdraw(double amount) {
    setState(() {
      if (_atm.withdraw(amount)) {
        _currentBalance = _atm.balance;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Withdrawal of \$${amount} successful')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Insufficient funds for withdrawal')),
        );
      }
    });
  }

  void _payBills(double amount) {
    setState(() {
      _atm.payBills(amount);
      _currentBalance = _atm.balance;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bill payment of \$${amount} successful')),
      );
    });
  }

  void _transferMoney(double amount) {
    setState(() {
      if (_atm.transferMoney(amount)) {
        _currentBalance = _atm.balance;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Transfer of \$${amount} successful')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Insufficient funds for transfer')),
        );
      }
    });
  }

  void _changePin(String newPin) {
    _atm.changePin(newPin);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PIN changed successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ATM Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ATMMenuButton(
              backgroundColor: Color.fromARGB(255, 0, 54, 77),
              icon: Icons.account_balance_wallet,
              text: 'Balance Inquiry',
              description: 'Check your current balance',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BalanceInquiryPage(atm: widget.atm),
                ),
              ),
            ),
            ATMMenuButton(
              backgroundColor: Color.fromARGB(255, 0, 54, 77),
              icon: Icons.attach_money,
              text: 'Withdraw Cash',
              description: 'Withdraw money from your account',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WithdrawCashPage(atm: widget.atm),
                ),
              ),
            ),
            ATMMenuButton(
              backgroundColor: Color.fromARGB(255, 0, 54, 77),
              icon: Icons.transfer_within_a_station,
              text: 'Transfer Money',
              description: 'Transfer funds to another account',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TransferMoneyPage(atm: widget.atm),
                ),
              ),
            ),
            ATMMenuButton(
              backgroundColor: Color.fromARGB(255, 0, 54, 77),
              icon: Icons.lock,
              text: 'Change PIN',
              description: 'Change your account PIN',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePinPage(atm: widget.atm),
                ),
              ),
            ),
            ATMMenuButton(
              backgroundColor: Color.fromARGB(255, 0, 54, 77),
              icon: Icons.payment,
              text: 'Pay Bills',
              description: 'Pay your utility and other bills',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PayBillsPage(atm: widget.atm),
                ),
              ),
            ),
            ATMMenuButton(
              backgroundColor: Color.fromARGB(255, 0, 54, 77),
              icon: Icons.savings,
              text: 'Deposit Money',
              description: 'Deposit funds into your account',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DepositMoneyPage(atm: widget.atm),
                ),
              ),
            ),
            ATMMenuButton(
              backgroundColor: Color.fromARGB(255, 0, 54, 77),
              icon: Icons.exit_to_app,
              text: 'Exit',
              description: 'Exit the ATM',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ATMMenuButton extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final String text;
  final String description;
  final VoidCallback onPressed;

  ATMMenuButton({
    required this.backgroundColor,
    required this.icon,
    required this.text,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 5,
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BalanceInquiryPage extends StatelessWidget {
  final ATM atm;

  const BalanceInquiryPage({Key? key, required this.atm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Balance Inquiry'),
        backgroundColor: const Color(0xFF00364D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your current savings:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${atm.balance.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Balance refreshed: \$${atm.balance.toStringAsFixed(2)}')),
                );
              },
              child: const Text('Refresh Balance'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4EC8F4)),
            ),
          ],
        ),
      ),
    );
  }
}

class WithdrawCashPage extends StatefulWidget {
  final ATM atm;

  WithdrawCashPage({Key? key, required this.atm}) : super(key: key);

  @override
  _WithdrawCashPageState createState() => _WithdrawCashPageState();
}

class _WithdrawCashPageState extends State<WithdrawCashPage> {
  double withdrawAmount = 0;

  Widget buildTransactionButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4EC8F4)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withdraw Cash'),
        backgroundColor: const Color(0xFF00364D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter amount to withdraw:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
              onChanged: (value) {
                setState(() {
                  withdrawAmount = double.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            buildTransactionButton('Withdraw', () {
              if (withdrawAmount <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a valid amount!')),
                );
                return;
              }
              if (widget.atm.withdraw(withdrawAmount)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Withdrawn: \$${withdrawAmount.toStringAsFixed(2)}. Remaining balance: \$${widget.atm.balance.toStringAsFixed(2)}')),
                );
                Navigator.pop(context, widget.atm.balance);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Insufficient balance!')),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

class TransferMoneyPage extends StatefulWidget {
  final ATM atm;

  TransferMoneyPage({Key? key, required this.atm}) : super(key: key);

  @override
  _TransferMoneyPageState createState() => _TransferMoneyPageState();
}

class _TransferMoneyPageState extends State<TransferMoneyPage> {
  double transferAmount = 0;
  final TextEditingController _accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Money'),
        backgroundColor: const Color(0xFF00364D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Transfer to account:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _accountController,
              decoration: const InputDecoration(labelText: 'Account Number'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter amount to transfer:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
              onChanged: (value) {
                setState(() {
                  transferAmount = double.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (widget.atm.withdraw(transferAmount)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Transferred: \$${transferAmount.toStringAsFixed(2)} to ${_accountController.text}')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Insufficient balance!')),
                  );
                }
              },
              child: const Text('Transfer'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4EC8F4)),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePinPage extends StatefulWidget {
  final ATM atm;

  ChangePinPage({Key? key, required this.atm}) : super(key: key);

  @override
  _ChangePinPageState createState() => _ChangePinPageState();
}

class _ChangePinPageState extends State<ChangePinPage> {
  String newPin = '';
  final TextEditingController _newPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change PIN'),
        backgroundColor: const Color(0xFF00364D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter your new PIN:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _newPinController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'New PIN'),
              maxLength: 4,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  newPin = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (newPin.length == 4) {
                  widget.atm.changePin(newPin);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: const Text('PIN changed successfully!')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('PIN must be 4 digits!')),
                  );
                }
              },
              child: const Text('Change PIN'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4EC8F4)),
            ),
          ],
        ),
      ),
    );
  }
}

class PayBillsPage extends StatefulWidget {
  final ATM atm;

  PayBillsPage({Key? key, required this.atm}) : super(key: key);

  @override
  _PayBillsPageState createState() => _PayBillsPageState();
}

class _PayBillsPageState extends State<PayBillsPage> {
  double billAmount = 0;
  final TextEditingController _billController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Bills'),
        backgroundColor: const Color(0xFF00364D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter bill amount:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _billController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
              onChanged: (value) {
                setState(() {
                  billAmount = double.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (widget.atm.payBills(billAmount)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Bill paid: \$${billAmount.toStringAsFixed(2)}')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Insufficient balance!')),
                  );
                }
              },
              child: const Text('Pay Bill'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4EC8F4)),
            ),
          ],
        ),
      ),
    );
  }
}

class DepositMoneyPage extends StatefulWidget {
  final ATM atm;

  DepositMoneyPage({Key? key, required this.atm}) : super(key: key);

  @override
  _DepositMoneyPageState createState() => _DepositMoneyPageState();
}

class _DepositMoneyPageState extends State<DepositMoneyPage> {
  double depositAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deposit Money'),
        backgroundColor: const Color(0xFF00364D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter amount to deposit:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
              onChanged: (value) {
                setState(() {
                  depositAmount = double.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.atm.deposit(depositAmount);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Deposited: \$${depositAmount.toStringAsFixed(2)}')),
                );
                Navigator.pop(context);
              },
              child: const Text('Deposit'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4EC8F4)),
            ),
          ],
        ),
      ),
    );
  }
}
