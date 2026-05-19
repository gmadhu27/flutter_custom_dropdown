import 'package:flutter/material.dart';

import '../models/country.dart';

class SelectCountryField extends StatelessWidget {
  const SelectCountryField({
    required this.country,
    required this.isDarkMode,
    required this.onTap,
    super.key,
  });

  final Country? country;
  final bool isDarkMode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        height: 54,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF181A22) : null,
          border: Border.all(
            color: isDarkMode
                ? const Color(0xFF555A6B)
                : const Color(0xFF777984),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                country == null
                    ? 'Select country'
                    : '${country!.flag}  ${country!.name}',
                style: TextStyle(
                  color: country == null
                      ? (isDarkMode
                            ? const Color(0xFFA6A8B3)
                            : const Color(0xFF4D4F59))
                      : (isDarkMode
                            ? const Color(0xFFF7F7FA)
                            : const Color(0xFF191A23)),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: isDarkMode ? const Color(0xFFE1E3EA) : null,
            ),
          ],
        ),
      ),
    );
  }
}
