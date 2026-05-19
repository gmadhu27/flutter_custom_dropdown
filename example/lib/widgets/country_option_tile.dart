import 'package:flutter/material.dart';

import '../models/country.dart';

class CountryOptionTile extends StatelessWidget {
  const CountryOptionTile({
    required this.country,
    required this.isDarkMode,
    super.key,
  });

  final Country country;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (country.sectionLabel != null) ...[
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 12),
            child: Text(
              country.sectionLabel!,
              style: const TextStyle(
                color: Color(0xFF7C7D86),
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              SizedBox(
                width: 46,
                child: Text(country.flag, style: const TextStyle(fontSize: 26)),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      country.name,
                      style: TextStyle(
                        color: isDarkMode
                            ? const Color(0xFFF7F7FA)
                            : const Color(0xFF20212A),
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      country.isoCode,
                      style: TextStyle(
                        color: isDarkMode
                            ? const Color(0xFFA6A8B3)
                            : const Color(0xFF858792),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                country.dialCode,
                style: TextStyle(
                  color: isDarkMode
                      ? const Color(0xFFE1E3EA)
                      : const Color(0xFF3C3F4B),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          color: isDarkMode ? const Color(0xFF2E303A) : const Color(0xFFE7E7EC),
        ),
      ],
    );
  }
}
