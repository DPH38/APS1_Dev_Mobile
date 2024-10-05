import 'package:flutter/material.dart';

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  TextEditingController _controller = TextEditingController();
  String _selectedUnit = 'Celsius';
  double _fahrenheit = 0;
  double _celsius = 0;
  double _kelvin = 0;

  void _convertTemperature() {
    double inputValue = double.tryParse(_controller.text) ?? 0;
    setState(() {
      if (_selectedUnit == 'Celsius') {
        _fahrenheit = (inputValue * 9 / 5) + 32;
        _kelvin = inputValue + 273.15;
        _celsius = inputValue;  // Mantendo o valor original de Celsius
      } else if (_selectedUnit == 'Fahrenheit') {
        _fahrenheit = inputValue;
        _celsius = (inputValue - 32) * 5 / 9;
        _kelvin = (inputValue + 459.67) * 5 / 9;
      } else if (_selectedUnit == 'Kelvin') {
        _fahrenheit = (inputValue - 273.15) * 9 / 5 + 32;
        _celsius = inputValue - 273.15;
        _kelvin = inputValue;
      }
    });
  }

  void _clearFields() {
    _controller.clear();
    setState(() {
      _fahrenheit = 0;
      _celsius = 0;
      _kelvin = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F7FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'CONVERSOR DE TEMPERATURA',
          style: TextStyle(
            color: Color(0xFF1A4782),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        leading: SizedBox.shrink(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),

            // Entrada de valores
            Text(
              'VALORES ENTRADA',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF1A4782),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Campo de entrada e dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFE2F1FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _convertTemperature(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '0',
                      hintStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Color(0xFFE2F1FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedUnit,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedUnit = newValue!;
                      });
                      _convertTemperature();
                    },
                    underline: Container(),
                    items: <String>['Celsius', 'Fahrenheit', 'Kelvin']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(fontSize: 18)),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Linha divisória
            Divider(color: Colors.blue, thickness: 1.0),
            SizedBox(height: 20),

            // Texto "SAÍDA"
            Text(
              'SAÍDA',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF1A4782),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Fahrenheit e Celsius/Kelvin
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Exibição do valor 1
                Column(
                  children: [
                    Container(
                      width: 110,
                      height: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          _selectedUnit == 'Fahrenheit'
                              ? '${_celsius.toStringAsFixed(0)}'
                              : '${_fahrenheit.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 32,
                            color: Color(0xFF1A4782),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _selectedUnit == 'Fahrenheit' ? 'Celsius' : 'Fahrenheit',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    Container(
                      width: 110,
                      height: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F1F1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          _selectedUnit == 'Kelvin'
                              ? '${_celsius.toStringAsFixed(0)}'
                              : '${_kelvin.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 32,
                            color: Color(0xFF1A4782),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _selectedUnit == 'Kelvin' ? 'Celsius' : 'Kelvin',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20),

            // Botão de limpar
            ElevatedButton(
              onPressed: _clearFields,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1A4782),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text('Limpar', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),

          ],
        ),
      ),
    );
  }
}

void main() => runApp(const TemperatureConverterApp());
