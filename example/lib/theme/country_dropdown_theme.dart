import 'package:flutter/material.dart';
import 'package:flutter_custom_dropdown_list/flutter_custom_dropdown_list.dart';

class CountryDropdownTheme {
  const CountryDropdownTheme._();

  static CustomDropdownTheme build({
    required BuildContext context,
    required bool isDarkMode,
    required BottomSheetMode mode,
  }) {
    final sheetColor = isDarkMode
        ? const Color(0xFF1A1B22)
        : const Color(0xFFFEFBFF);
    final titleColor = isDarkMode
        ? const Color(0xFFF7F7FA)
        : const Color(0xFF20212A);
    final accentColor = isDarkMode
        ? const Color(0xFF9DB2FF)
        : const Color(0xFF002A86);
    final searchFillColor = isDarkMode
        ? const Color(0xFF242630)
        : const Color(0xFFFAFAFD);
    final searchBorderColor = isDarkMode
        ? const Color(0xFF343744)
        : const Color(0xFFE2E3EA);
    final searchHintColor = isDarkMode
        ? const Color(0xFFA6A8B3)
        : const Color(0xFF7E808A);

    return CustomDropdownTheme(
      backgroundColor: sheetColor,
      backIconColor: accentColor,
      titleTextStyle:
          (mode == BottomSheetMode.full
                  ? Theme.of(context).textTheme.titleMedium
                  : Theme.of(context).textTheme.titleLarge)
              ?.copyWith(
                fontWeight: mode == BottomSheetMode.full
                    ? FontWeight.w500
                    : FontWeight.w800,
                color: mode == BottomSheetMode.full ? accentColor : titleColor,
              ),
      searchBoxDecoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: searchFillColor,
        hintText: 'Search country / code',
        hintStyle: TextStyle(
          color: searchHintColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: searchHintColor,
          size: 19,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 44,
          minHeight: 44,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: searchBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: accentColor, width: 1.4),
        ),
      ),
      bottomSheetBoxDecoration: BoxDecoration(
        color: sheetColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
    );
  }
}
