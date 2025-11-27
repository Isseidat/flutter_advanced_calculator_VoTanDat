import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/history_provider.dart';

class HistoryPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final history = context.watch<HistoryProvider>().lastThree;

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return GestureDetector(
            onTap: () => Navigator.pop(context, item.expression),
            child: Container(
              width: 180,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.expression,
                      style: const TextStyle(fontSize: 14)),
                  Text(item.result,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
