import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';

class CalculatorButton extends StatelessWidget {
  final String label;

  const CalculatorButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CalculatorProvider>();

    return GestureDetector(
      onTap: () {
        switch (label) {
          // --- CLEAR ---
          case "C":
            provider.clear();
            break;
          case "CE":
            provider.clearEntry();
            break;

          // --- EQUAL ---
          case "=":
            provider.calculate();
            break;

          // --- SIGN / PERCENT ---
          case "+/-":
            provider.toggleSign();
            break;
          case "%":
            provider.addPercentage();
            break;

          // --- SCIENTIFIC FUNCTIONS ---
          case "sin":
          case "cos":
          case "tan":
          case "log":
          case "ln":
          case "√":
            provider.addFunction(label);
            break;

          case "^":
            provider.addPower();
            break;

          // --- MEMORY BUTTONS ---
          case "M+":
            provider.memoryAdd();
            break;
          case "M-":
            provider.memorySubtract();
            break;
          case "MR":
            provider.memoryRecall();
            break;
          case "MC":
            provider.memoryClear();
            break;

          // --- DEFAULT: số, dấu, ngoặc ---
          default:
            provider.addToExpression(label);
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 22,
            color: Color.fromARGB(255, 255, 153, 0),
          ),
        ),
      ),
    );
  }
}
