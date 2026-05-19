import 'package:flutter/material.dart';

class SheetModeActions extends StatelessWidget {
  const SheetModeActions({
    required this.isDarkMode,
    required this.onNormalPressed,
    required this.onModalPressed,
    required this.onFullPressed,
    required this.onWithoutSearchPressed,
    super.key,
  });

  final bool isDarkMode;
  final VoidCallback onNormalPressed;
  final VoidCallback onModalPressed;
  final VoidCallback onFullPressed;
  final VoidCallback onWithoutSearchPressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        SheetModeButton(
          isDarkMode: isDarkMode,
          icon: Icons.vertical_align_bottom_rounded,
          label: 'Normal sheet',
          onPressed: onNormalPressed,
        ),
        SheetModeButton(
          isDarkMode: isDarkMode,
          icon: Icons.open_in_new_rounded,
          label: 'Modal sheet',
          onPressed: onModalPressed,
        ),
        SheetModeButton(
          isDarkMode: isDarkMode,
          icon: Icons.fullscreen_rounded,
          label: 'Full screen',
          onPressed: onFullPressed,
        ),
        SheetModeButton(
          isDarkMode: isDarkMode,
          icon: Icons.search_off_rounded,
          label: 'Without search',
          onPressed: onWithoutSearchPressed,
        ),
      ],
    );
  }
}

class SheetModeButton extends StatelessWidget {
  const SheetModeButton({
    required this.isDarkMode,
    required this.icon,
    required this.label,
    required this.onPressed,
    super.key,
  });

  final bool isDarkMode;
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: isDarkMode
            ? const Color(0xFFAFC0FF)
            : const Color(0xFF002A86),
        side: BorderSide(
          color: isDarkMode ? const Color(0xFF353847) : const Color(0xFFD2D5E2),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
      ),
    );
  }
}
