import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../models/calculator_mode.dart';
import 'calculator_button.dart'; // nếu có component CalculatorButton

class ButtonGrid extends StatelessWidget {
  const ButtonGrid({super.key}); // quan trọng: const + key

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalculatorProvider>();

    switch (provider.mode) {
      case CalculatorMode.basic:
        return _buildGrid(provider.basicButtons);
      case CalculatorMode.scientific:
        return _buildGrid(provider.scientificButtons, columns: 6);
      case CalculatorMode.programmer:
        return _buildGrid(provider.programmerButtons, columns: 5);
    }
  }

  Widget _buildGrid(List<String> buttons, {int columns = 4}) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: buttons.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        childAspectRatio: 1.1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (_, i) => CalculatorButton(label: buttons[i]),
    );
  }
}
