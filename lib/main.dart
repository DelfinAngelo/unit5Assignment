import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _firstNumController = TextEditingController();
  final TextEditingController _secondNumController = TextEditingController();
  String result = '0';

  // Function to perform arithmetic operations
  void calculate(String operation) {
    setState(() {
      double firstNum = double.parse(_firstNumController.text);
      double secondNum = double.parse(_secondNumController.text);
      switch (operation) {
        case 'add':
          result = (firstNum + secondNum).toString();
          break;
        case 'subtract':
          result = (firstNum - secondNum).toString();
          break;
        case 'multiply':
          result = (firstNum * secondNum).toString();
          break;
        case 'divide':
          result = secondNum != 0 ? (firstNum / secondNum).toStringAsFixed(2) : 'Error';
          break;
      }
    });
  }

  // Function to clear inputs and result
  void clear() {
    setState(() {
      _firstNumController.clear();
      _secondNumController.clear();
      result = '0';
    });
  }

  // Widget to create the operation rows
  Widget operationRow(String label, String operationSymbol, String operationType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextField(
              controller: _firstNumController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Enter first number: "),
            ),
          ),
          Text(operationSymbol, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Expanded(
            child: TextField(
              controller: _secondNumController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Enter second number: "),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.calculate, color: Colors.yellow),
            onPressed: () => calculate(operationType),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Calculator"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Display Result
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                'Result: $result',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            
            // Operation Rows
            operationRow("Add", "+", "add"),
            operationRow("Subtract", "-", "subtract"),
            operationRow("Multiply", "×", "multiply"),
            operationRow("Divide", "÷", "divide"),
            
            // Clear Button
            ElevatedButton(
              onPressed: clear,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text("Clear", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
