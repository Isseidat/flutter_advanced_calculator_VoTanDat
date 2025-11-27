import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../models/calculator_mode.dart';

class DisplayArea extends StatelessWidget {
  const DisplayArea({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalculatorProvider>();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Previous result
          AnimatedOpacity(
            opacity: provider.previousResult.isNotEmpty ? 0.6 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Text(
              provider.previousResult,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ),

          // Current Expression (Scroll)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              provider.expression,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Error Message
          AnimatedOpacity(
            opacity: provider.errorMessage.isNotEmpty ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: Text(
              provider.errorMessage,
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 16,
              ),
            ),
          ),

          const SizedBox(height: 4),

          // Mode Indicator (DEG/RAD)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                provider.angleMode == AngleMode.degrees ? "DEG" : "RAD",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.tealAccent,
                ),
              ),
              const SizedBox(width: 12),

              // Memory Indicator
              if (provider.memoryValue != 0)
                const Icon(Icons.memory, color: Colors.orange, size: 20),
            ],
          )
        ],
      ),
    );
  }
}
