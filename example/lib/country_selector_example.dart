import 'package:flutter/material.dart';
import 'package:flutter_custom_dropdown_list/flutter_custom_dropdown_list.dart';

import 'data/countries.dart';
import 'models/country.dart';
import 'theme/country_dropdown_theme.dart';
import 'widgets/country_option_tile.dart';
import 'widgets/select_country_field.dart';
import 'widgets/sheet_mode_actions.dart';
import 'widgets/step_progress_indicator.dart';
import 'widgets/theme_mode_switch.dart';

class CountrySelectorExample extends StatefulWidget {
  const CountrySelectorExample({
    required this.isDarkMode,
    required this.onThemeChanged,
    super.key,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  @override
  State<CountrySelectorExample> createState() => _CountrySelectorExampleState();
}

class _CountrySelectorExampleState extends State<CountrySelectorExample> {
  Country? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isDarkMode
        ? const Color(0xFFF7F7FA)
        : const Color(0xFF191A23);

    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (scaffoldContext) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        color: const Color(0xFF002A86),
                        style: IconButton.styleFrom(
                          minimumSize: const Size.square(40),
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      const Spacer(),
                      ThemeModeSwitch(
                        isDarkMode: widget.isDarkMode,
                        onChanged: widget.onThemeChanged,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const StepProgressIndicator(),
                  const SizedBox(height: 46),
                  Text(
                    'Where do we find you most days?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 26),
                  SelectCountryField(
                    country: _selectedCountry,
                    isDarkMode: widget.isDarkMode,
                    onTap: () => _openCountrySelector(
                      scaffoldContext,
                      BottomSheetMode.modal,
                    ),
                  ),
                  const SizedBox(height: 18),
                  SheetModeActions(
                    isDarkMode: widget.isDarkMode,
                    onNormalPressed: () => _openCountrySelector(
                      scaffoldContext,
                      BottomSheetMode.normal,
                    ),
                    onModalPressed: () => _openCountrySelector(
                      scaffoldContext,
                      BottomSheetMode.modal,
                    ),
                    onFullPressed: () => _openCountrySelector(
                      scaffoldContext,
                      BottomSheetMode.full,
                    ),
                    onWithoutSearchPressed: () => _openCountrySelector(
                      scaffoldContext,
                      BottomSheetMode.modal,
                      showSearch: false,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _openCountrySelector(
    BuildContext context,
    BottomSheetMode mode, {
    bool showSearch = true,
  }) {
    CustomDropdownHelper.showDropdown<Country>(
      context: context,
      items: countries,
      title: mode == BottomSheetMode.full
          ? 'Select country code'
          : 'Select country',
      bottomSheetMode: mode,
      showSearch: showSearch,
      onItemSelected: (country) {
        setState(() => _selectedCountry = country);
      },
      itemBuilder: (country) {
        return CountryOptionTile(
          country: country,
          isDarkMode: widget.isDarkMode,
        );
      },
      itemSearchCondition: (country, searchText) => country.matches(searchText),
      theme: CountryDropdownTheme.build(
        context: context,
        isDarkMode: widget.isDarkMode,
        mode: mode,
      ),
    );
  }
}
