import 'package:flutter/material.dart';
import 'package:flutter_custom_dropdown_list/flutter_custom_dropdown_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Country Selector',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF002A86)),
        fontFamily: 'SF Pro Display',
        scaffoldBackgroundColor: const Color(0xFFF8F8FB),
        useMaterial3: true,
      ),
      home: const CountrySelectorExample(),
    );
  }
}

class CountrySelectorExample extends StatefulWidget {
  const CountrySelectorExample({super.key});

  @override
  State<CountrySelectorExample> createState() => _CountrySelectorExampleState();
}

class _CountrySelectorExampleState extends State<CountrySelectorExample> {
  Country? _selectedCountry;

  final List<Country> _countries = const [
    Country(
      flag: '🇦🇴',
      name: 'Angola',
      isoCode: 'AGO',
      dialCode: '+244',
      isAvailableMarket: true,
      sectionLabel: 'AVAILABLE MARKETS',
    ),
    Country(
      flag: '🇨🇩',
      name: 'DR Congo',
      isoCode: 'COD',
      dialCode: '+243',
      isAvailableMarket: true,
    ),
    Country(
      flag: '🇬🇲',
      name: 'Gambia',
      isoCode: 'GMB',
      dialCode: '+220',
      isAvailableMarket: true,
    ),
    Country(
      flag: '🇸🇱',
      name: 'Sierra Leone',
      isoCode: 'SLE',
      dialCode: '+232',
      isAvailableMarket: true,
    ),
    Country(
      flag: '🇦🇫',
      name: 'Afghanistan',
      isoCode: 'AFG',
      dialCode: '+93',
      sectionLabel: 'ALL COUNTRIES',
    ),
    Country(flag: '🇦🇱', name: 'Albania', isoCode: 'ALB', dialCode: '+355'),
    Country(flag: '🇩🇿', name: 'Algeria', isoCode: 'DZA', dialCode: '+213'),
    Country(flag: '🇦🇷', name: 'Argentina', isoCode: 'ARG', dialCode: '+54'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Builder(
          builder: (scaffoldContext) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 16),
                  const StepProgressIndicator(),
                  const SizedBox(height: 46),
                  Text(
                    'Where do we find you most days?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: const Color(0xFF191A23),
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 26),
                  SelectCountryField(
                    country: _selectedCountry,
                    onTap: () => _openCountrySelector(
                      scaffoldContext,
                      BottomSheetMode.modal,
                    ),
                  ),
                  const SizedBox(height: 18),
                  SheetModeActions(
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
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _openCountrySelector(BuildContext context, BottomSheetMode mode) {
    CustomDropdownHelper.showDropdown<Country>(
      context: context,
      items: _countries,
      title: mode == BottomSheetMode.full
          ? 'Select country code'
          : 'Select country',
      bottomSheetMode: mode,
      showSearch: true,
      onItemSelected: (country) {
        setState(() => _selectedCountry = country);
      },
      itemBuilder: (country) {
        return CountryOptionTile(country: country);
      },
      itemSearchCondition: (country, searchText) {
        return country.name.toLowerCase().contains(searchText) ||
            country.isoCode.toLowerCase().contains(searchText) ||
            country.dialCode.contains(searchText);
      },
      theme: CustomDropdownTheme(
        backgroundColor: const Color(0xFFFEFBFF),
        backIconColor: const Color(0xFF002A86),
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
          color: const Color(0xFF20212A),
        ),
        searchBoxDecoration: InputDecoration(
          hintText: 'Search country / code',
          hintStyle: const TextStyle(color: Color(0xFF7E808A), fontSize: 16),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF4F5665)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFC7C8D0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF002A86), width: 1.4),
          ),
        ),
        bottomSheetBoxDecoration: const BoxDecoration(
          color: Color(0xFFFEFBFF),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
    );
  }
}

class SheetModeActions extends StatelessWidget {
  const SheetModeActions({
    required this.onNormalPressed,
    required this.onModalPressed,
    required this.onFullPressed,
    super.key,
  });

  final VoidCallback onNormalPressed;
  final VoidCallback onModalPressed;
  final VoidCallback onFullPressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        SheetModeButton(
          icon: Icons.vertical_align_bottom_rounded,
          label: 'Normal sheet',
          onPressed: onNormalPressed,
        ),
        SheetModeButton(
          icon: Icons.open_in_new_rounded,
          label: 'Modal sheet',
          onPressed: onModalPressed,
        ),
        SheetModeButton(
          icon: Icons.fullscreen_rounded,
          label: 'Full screen',
          onPressed: onFullPressed,
        ),
      ],
    );
  }
}

class SheetModeButton extends StatelessWidget {
  const SheetModeButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    super.key,
  });

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
        foregroundColor: const Color(0xFF002A86),
        side: const BorderSide(color: Color(0xFFD2D5E2)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class SelectCountryField extends StatelessWidget {
  const SelectCountryField({
    required this.country,
    required this.onTap,
    super.key,
  });

  final Country? country;
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
          border: Border.all(color: const Color(0xFF777984)),
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
                      ? const Color(0xFF4D4F59)
                      : const Color(0xFF191A23),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.keyboard_arrow_down_rounded),
          ],
        ),
      ),
    );
  }
}

class CountryOptionTile extends StatelessWidget {
  const CountryOptionTile({required this.country, super.key});

  final Country country;

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
                      style: const TextStyle(
                        color: Color(0xFF20212A),
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      country.isoCode,
                      style: const TextStyle(
                        color: Color(0xFF858792),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                country.dialCode,
                style: const TextStyle(
                  color: Color(0xFF3C3F4B),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Color(0xFFE7E7EC)),
      ],
    );
  }
}

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

class Country {
  const Country({
    required this.flag,
    required this.name,
    required this.isoCode,
    required this.dialCode,
    this.isAvailableMarket = false,
    this.sectionLabel,
  });

  final String flag;
  final String name;
  final String isoCode;
  final String dialCode;
  final bool isAvailableMarket;
  final String? sectionLabel;

  @override
  String toString() => '$name $isoCode $dialCode';
}
