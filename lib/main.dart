import 'package:flutter/material.dart';
import 'package:iosatm/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ATM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class ATM {
  String _pinCode = '1234';
  double _balance = 1000.0;
  int _pinAttempts = 0;
  bool _authenticated = false;

  bool verifyPin(String enteredPin) {
    if (enteredPin == _pinCode) {
      _authenticated = true;
      return true;
    } else {
      _pinAttempts++;
      return false;
    }
  }

  bool get isLocked => _pinAttempts >= 3;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ATM _atm = ATM();
  String _enteredPin = '';
  String _message = '';
  bool _isLocked = false;
  bool _showKeypad = false;
  void _handleButtonPress(String digit) {
    if (_enteredPin.length < 4) {
      setState(() {
        _enteredPin += digit;
      });

      if (_enteredPin.length == 4) {
        _handlePinEntry();
      }
    }
  }

  void _handlePinEntry() {
    setState(() {
      if (_atm.verifyPin(_enteredPin)) {
        _message = 'PIN accepted. Welcome!';
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ATMHomePage()),
        );
      } else {
        _isLocked = _atm.isLocked;
        _message = _isLocked
            ? 'Too many incorrect attempts. ATM is locked.'
            : 'Incorrect PIN. Attempts left: ${3 - _atm._pinAttempts}';
        _enteredPin = '';
      }
    });
  }

  void _clearPin() {
    setState(() {
      _enteredPin = '';
    });
  }

  void _dismissKeypad() {
    setState(() {
      _showKeypad = false;
    });
  }

  Widget _buildPinDisplay() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showKeypad = true;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                index < _enteredPin.length ? '*' : '',
                style: const TextStyle(fontSize: 24),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildKeypad() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var row in [
          ['1', '2', '3'],
          ['4', '5', '6'],
          ['7', '8', '9'],
          ['Clear', '0', 'Enter'],
        ])
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((digit) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _isLocked
                      ? null
                      : () {
                          if (digit == 'Clear') {
                            _clearPin();
                          } else if (digit == 'Enter') {
                            if (_enteredPin.length == 4) {
                              _handlePinEntry();
                            }
                          } else {
                            _handleButtonPress(digit);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // White background
                    side: const BorderSide(
                      color: Color(0xFF00364D), // Dark blue border
                      width: 0,
                    ),
                    fixedSize: const Size(80, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    digit,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF00364D), // Light blue text
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _dismissKeypad,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: GestureDetector(
          onTap: () {},
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      fontSize: 48,
                    ),
                    children: [
                      TextSpan(
                        text: 'A',
                        style: TextStyle(
                          color: Color(0xFF4EC8F4),
                        ),
                      ),
                      TextSpan(
                        text: 'T',
                        style: TextStyle(
                          color: Color(0xFF4EC8F4),
                        ),
                      ),
                      TextSpan(
                        text: 'M',
                        style: TextStyle(
                          color: Color(0xFF00364D),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text('ENTER YOUR PIN'),
                const SizedBox(height: 16),
                _buildPinDisplay(),
                const SizedBox(height: 16),
                Text(
                  _message,
                  style: const TextStyle(color: Colors.red),
                ),
                if (_showKeypad) const SizedBox(height: 16),
                if (_showKeypad) _buildKeypad(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
