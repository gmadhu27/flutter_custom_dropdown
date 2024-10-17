class DropdownItem {
  final int id;
  final String name;

  DropdownItem({required this.id, required this.name});
}

class DropdownItemMapper {
  // Converts a DropdownItem to a Map
  static Map<String, dynamic> toMap(DropdownItem item) {
    return {
      'id': item.id,
      'name': item.name,
    };
  }

  // Converts a Map to a DropdownItem
  static DropdownItem fromMap(Map<String, dynamic> map) {
    return DropdownItem(
      id: map['id'],
      name: map['name'],
    );
  }
}
