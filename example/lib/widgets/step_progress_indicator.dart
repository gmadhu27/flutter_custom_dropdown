import 'package:flutter/material.dart';

class StepProgressIndicator extends StatelessWidget {
  const StepProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(6, (index) {
        final isActive = index == 0;
        return Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.only(right: index == 5 ? 0 : 8),
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF1D4DCE)
                  : const Color(0xFFDADAE0),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        );
      }),
    );
  }
}
