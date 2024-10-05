import 'package:flutter/material.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = '0';
  String _currentInput = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operator = '';

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _output = '0';
        _currentInput = '';
        _num1 = 0;
        _num2 = 0;
        _operator = '';
      } else if (value == '+' || value == '-' || value == '*' || value == '/' || value == '%') {
        _num1 = double.parse(_currentInput);
        _operator = value;
        _currentInput = '';
      } else if (value == '=') {
        _num2 = double.parse(_currentInput);
        _calculateResult();
      } else if (value == '+/-') {
        _currentInput = (double.parse(_currentInput) * -1).toString();
        _output = _currentInput;
      } else {
        _currentInput += value;
        _output = _currentInput;
      }
    });
  }

  void _calculateResult() {
    double result = 0;
    if (_operator == '+') {
      result = _num1 + _num2;
    } else if (_operator == '-') {
      result = _num1 - _num2;
    } else if (_operator == '*') {
      result = _num1 * _num2;
    } else if (_operator == '/') {
      // Verificação para divisão por zero
      if (_num2 == 0) {
        _output = 'Não é possível dividir por zero';
        _currentInput = '';
        return; // Se dividir por zero, finaliza
      } else {
        result = _num1 / _num2;
      }
    } else if (_operator == '%') {
      result = _num1 % _num2;
    }

    _output = result.toString();
    _currentInput = _output;
  }


  Widget _buildButton(String value, {Color color = Colors.white}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(24),
            backgroundColor: color,
          ),
          onPressed: () => _buttonPressed(value),
          child: Text(
            value,
            style: TextStyle(fontSize: 24, color: Colors.blue),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              color: Colors.white,
              child: Text(
                _output,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: <Widget>[
                  _buildButton('C', color: Colors.lightBlue[100]!),
                  _buildButton('+/-', color: Colors.lightBlue[100]!),
                  _buildButton('%', color: Colors.lightBlue[100]!),
                  _buildButton('/', color: Colors.blue[300]!),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('*', color: Colors.blue[300]!),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('-', color: Colors.blue[300]!),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('+', color: Colors.blue[300]!),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton('0', color: Colors.grey[200]!),
                  _buildButton(',', color: Colors.grey[200]!),
                  _buildButton('=', color: Colors.blue[300]!),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
