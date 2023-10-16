import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
      theme: ThemeData.dark(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _output = '';

  void _onButtonPressed(String buttonText) {
    if (buttonText == '=') {
      try {
        final result = Parser().parse(_input);
        setState(() {
          _output = result.evaluate(EvaluationType.REAL, ContextModel()).toString();
        });
      } catch (e) {
        setState(() {
          _output = 'Error';
        });
      }
    } else if (buttonText == 'C') {
      setState(() {
        _input = '';
        _output = '';
      });
    } else {
      setState(() {
        _input += buttonText;
      });
    }
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: 80,
      width: 80, // Agregado para controlar el ancho de los botones
      child: ElevatedButton(
        onPressed: () => _onButtonPressed(buttonText),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 36.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _input,
                style: TextStyle(fontSize: 48.0),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20), // Agrega espacio entre las filas de botones
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribuye los botones equitativamente en el espacio
            children: <Widget>[
              buildButton('7', 1, Colors.blue),
              buildButton('8', 1, Colors.blue),
              buildButton('9', 1, Colors.blue),
              buildButton('/', 1, Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildButton('4', 1, Colors.blue),
              buildButton('5', 1, Colors.blue),
              buildButton('6', 1, Colors.blue),
              buildButton('*', 1, Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildButton('1', 1, Colors.blue),
              buildButton('2', 1, Colors.blue),
              buildButton('3', 1, Colors.blue),
              buildButton('-', 1, Colors.orange),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildButton('C', 1, Colors.red),
              buildButton('0', 1, Colors.blue),
              buildButton('=', 1, Colors.orange),
              buildButton('+', 1, Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}