import 'package:flutter/material.dart';

class ThemeModeSwitch extends StatelessWidget {
  const ThemeModeSwitch({
    required this.isDarkMode,
    required this.onChanged,
    super.key,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<bool>(
      segments: const [
        ButtonSegment<bool>(
          value: false,
          icon: Icon(Icons.light_mode_rounded, size: 16),
          label: Text('Light'),
        ),
        ButtonSegment<bool>(
          value: true,
          icon: Icon(Icons.dark_mode_rounded, size: 16),
          label: Text('Dark'),
        ),
      ],
      selected: {isDarkMode},
      showSelectedIcon: false,
      onSelectionChanged: (selection) => onChanged(selection.first),
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
