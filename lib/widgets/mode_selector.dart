import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../models/calculator_mode.dart';

class ModeSelector extends StatelessWidget {
  const ModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalculatorProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _modeButton(context, "Basic", CalculatorMode.basic, provider),
        _modeButton(context, "Scientific", CalculatorMode.scientific, provider),
        _modeButton(context, "Programmer", CalculatorMode.programmer, provider),
      ],
    );
  }

  Widget _modeButton(
      BuildContext context,
      String label,
      CalculatorMode mode,
      CalculatorProvider provider) {
    final isSelected = provider.mode == mode;

    return GestureDetector(
      onTap: () => provider.setMode(mode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.grey[800],
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.white : Colors.grey[300])),
      ),
    );
  }
}
