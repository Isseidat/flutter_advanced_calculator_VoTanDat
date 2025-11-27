import 'package:flutter/material.dart';
import '../models/calculator_mode.dart';
import 'dart:math';

class CalculatorProvider extends ChangeNotifier {
  String _expression = '';
  String _result = '0';
  String _previousResult = '';
  String _errorMessage = '';

  CalculatorMode _mode = CalculatorMode.basic;
  AngleMode _angleMode = AngleMode.degrees;
  double _memory = 0;

  // ==============================
  // GETTERS
  // ==============================
  String get expression => _expression;
  String get result => _result;
  String get previousResult => _previousResult;
  String get errorMessage => _errorMessage;
  CalculatorMode get mode => _mode;
  AngleMode get angleMode => _angleMode;
  double get memoryValue => _memory;

  // ==============================
  // BUTTON LISTS
  // ==============================
  List<String> get basicButtons => [
        '7', '8', '9', '÷',
        '4', '5', '6', '×',
        '1', '2', '3', '-',
        '0', '.', '=', '+',
        'CE', 'C', '+/-', '%',
      ];

  List<String> get programmerButtons => [
        'A', 'B', 'C', 'D', 'E',
        '7', '8', '9', '÷', 'F',
        '4', '5', '6', '×', 'XOR',
        '1', '2', '3', '-', 'OR',
        '0', '=', '+', 'AND',
      ];

  List<String> get scientificButtons => [
        'sin', 'cos', 'tan', 'log', 'ln', '√',
        '7', '8', '9', '÷', '(', ')',
        '4', '5', '6', '×', '^', '%',
        '1', '2', '3', '-', 'CE', 'C',
        '0', '.', '=', '+', '+/-', 'π',
        'M+', 'M-', 'MR', 'MC',
      ];

  // ==============================
  // EXPRESSION EDITING
  // ==============================
  void addToExpression(String value) {
    _expression += value;
    notifyListeners();
  }

  void addFunction(String func) {
    if (func == '√') {
      _expression += '√(';
    } else {
      _expression += '$func(';
    }
    notifyListeners();
  }

  void clearEntry() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      notifyListeners();
    }
  }

  void clear() {
    _expression = '';
    _result = '0';
    _errorMessage = '';
    _previousResult = '';
    notifyListeners();
  }

  // ==============================
  // ADDITIONAL FUNCTIONS
  // ==============================
  void toggleSign() {
    if (_expression.isEmpty) return;
    if (_expression.startsWith('-')) {
      _expression = _expression.substring(1);
    } else {
      _expression = '-$_expression';
    }
    notifyListeners();
  }

  void addPercentage() {
    if (_expression.isEmpty) return;
    try {
      double val = double.parse(_expression);
      _expression = (val / 100).toString();
    } catch (_) {}
    notifyListeners();
  }

  void addPower() {
    _expression += "^";
    notifyListeners();
  }

  // ==============================
  // MODE SETTINGS
  // ==============================
  void setMode(CalculatorMode mode) {
    _mode = mode;
    notifyListeners();
  }

  void setAngleMode(AngleMode mode) {
    _angleMode = mode;
    notifyListeners();
  }

  // ==============================
  // MEMORY FUNCTIONS
  // ==============================
  void memoryAdd() {
    _memory += double.tryParse(_result) ?? 0;
    notifyListeners();
  }

  void memorySubtract() {
    _memory -= double.tryParse(_result) ?? 0;
    notifyListeners();
  }

  void memoryRecall() {
    _expression = _memory.toString();
    _result = _expression;
    notifyListeners();
  }

  void memoryClear() {
    _memory = 0;
    notifyListeners();
  }

  // ==============================
  // CALCULATE
  // ==============================
  void calculate() {
    if (_expression.isEmpty) return;

    final output = calculateExpression(_expression);

    _previousResult = _result;

    if (output.startsWith("Error")) {
      _result = output;
      _errorMessage = output;
    } else {
      _result = output;
      _errorMessage = '';
    }

    notifyListeners();
  }

  // ==============================
  // MAIN LOGIC PROCESSOR
  // ==============================
  String calculateExpression(String input) {
    try {
      // Xử lý phép nhân: × hoặc x → *
      input = input.replaceAll(RegExp(r'[×x]'), '*');

      input = input.replaceAll('÷', '/');
      input = input.replaceAll('π', pi.toString());

      // 1. SCIENTIFIC FUNCTIONS
final functions = ['sin', 'cos', 'tan', 'log', 'ln', '√', 'sqrt'];

for (String func in functions) {
  final regExp = RegExp('$func\\(([^()]*)\\)');   // FIX: cho phép rỗng

  input = input.replaceAllMapped(regExp, (match) {
    String inside = match[1]!.trim();

    if (inside.isEmpty) inside = "0";             // FIX: tránh crash

    double val = double.parse(calculateExpression(inside));

    switch (func) {
      case 'sin':
        if (_angleMode == AngleMode.degrees) val = val * pi / 180;
        return sin(val).toString();
      case 'cos':
        if (_angleMode == AngleMode.degrees) val = val * pi / 180;
        return cos(val).toString();
      case 'tan':
        if (_angleMode == AngleMode.degrees) val = val * pi / 180;
        return tan(val).toString();
      case 'log':
        return (log(val) / ln10).toString();
      case 'ln':
        return log(val).toString();
      case '√':
      case 'sqrt':
        return sqrt(val).toString();
    }
    return val.toString();
  });
}


      // 2. POWER ^
      while (input.contains('^')) {
        final parts = input.split('^');
        double a = double.parse(calculateExpression(parts[0]));
        double b = double.parse(calculateExpression(parts[1]));
        input = pow(a, b).toString();
      }

      // 3. PROGRAMMER MODE AND/OR/XOR
      if (input.contains("AND")) {
        final parts = input.split("AND");
        int a = int.parse(parts[0].trim(), radix: 16);
        int b = int.parse(parts[1].trim(), radix: 16);
        return "0x${(a & b).toRadixString(16).toUpperCase()}";
      }
      if (input.contains("OR")) {
        final parts = input.split("OR");
        int a = int.parse(parts[0].trim(), radix: 16);
        int b = int.parse(parts[1].trim(), radix: 16);
        return "0x${(a | b).toRadixString(16).toUpperCase()}";
      }
      if (input.contains("XOR")) {
        final parts = input.split("XOR");
        int a = int.parse(parts[0].trim(), radix: 16);
        int b = int.parse(parts[1].trim(), radix: 16);
        return "0x${(a ^ b).toRadixString(16).toUpperCase()}";
      }

      return _evalBasic(input).toString();
    } catch (e) {
      return "Error";
    }
  }

  // ==============================
  // BASIC + - * /
  // ==============================
  double _evalBasic(String expr) {
    try {
      // FIX nhân trong basic eval
      expr = expr.replaceAll(RegExp(r'[×x]'), '*');
      expr = expr.replaceAll('÷', '/');

      // Xử lý dấu ngoặc
      while (expr.contains('(')) {
        expr = expr.replaceAllMapped(
          RegExp(r'\(([^()]+)\)'),
          (m) => _evalBasic(m.group(1)!).toString(),
        );
      }

      // Thêm khoảng trắng để tách operators
      expr = expr.replaceAll('+', ' + ')
                 .replaceAll('-', ' - ')
                 .replaceAll('*', ' * ')
                 .replaceAll('/', ' / ');

      List<String> tokens = expr.trim().split(RegExp(r'\s+'));

      // * và /
      for (int i = 0; i < tokens.length; i++) {
        if (tokens[i] == '*' || tokens[i] == '/') {
          double a = double.parse(tokens[i - 1]);
          double b = double.parse(tokens[i + 1]);

          if (tokens[i] == '*' ) {
            tokens[i - 1] = (a * b).toString();
          } else {
            if (b == 0) throw Exception("Division by zero");
            tokens[i - 1] = (a / b).toString();
          }

          tokens.removeAt(i);
          tokens.removeAt(i);
          i--;
        }
      }

      // + và -
      double res = double.parse(tokens[0]);
      for (int i = 1; i < tokens.length; i += 2) {
        double v = double.parse(tokens[i + 1]);
        if (tokens[i] == '+') res += v;
        if (tokens[i] == '-') res -= v;
      }

      return res;
    } catch (_) {
      throw Exception("Invalid expression");
    }
  }
}
