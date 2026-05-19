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

  bool matches(String searchText) {
    return name.toLowerCase().contains(searchText) ||
        isoCode.toLowerCase().contains(searchText) ||
        dialCode.contains(searchText);
  }

  @override
  String toString() => '$name $isoCode $dialCode';
}
