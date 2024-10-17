import 'package:flutter/material.dart';
import 'package:flutter_custom_dropdown/src/helper/dropdown_item.dart';
import 'helper/bottom_sheet_mode.dart';

class CustomDropdownHelper {
  static void showDropdown({
    required BuildContext context,
    required List<DropdownItem> items,
    required String title,
    required Function(DropdownItem?) onItemSelected,
    BottomSheetMode bottomSheetMode =
        BottomSheetMode.normal, // Default to modal
  }) {
    _showCustomDropdown(
      context: context,
      items: items,
      title: title,
      onItemSelected: onItemSelected,
      bottomSheetMode: bottomSheetMode,
    );
  }

  static void _showCustomDropdown({
    required BuildContext context,
    required List<DropdownItem> items,
    required String title,
    required Function(DropdownItem?) onItemSelected,
    BottomSheetMode bottomSheetMode = BottomSheetMode.normal,
  }) {
    // Show the bottom sheet based on the mode
    if (bottomSheetMode == BottomSheetMode.modal) {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        builder: (context) {
          return _CustomDropdownBottomSheet(
            items: items,
            title: title,
            onItemSelected: onItemSelected,
          );
        },
      );
    } else if (bottomSheetMode == BottomSheetMode.normal) {
      showBottomSheet(
        context: context,
        builder: (context) {
          return _CustomDropdownBottomSheet(
            items: items,
            title: title,
            onItemSelected: onItemSelected,
          );
        },
      );
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => _CustomDropdownBottomSheet(
          items: items,
          title: title,
          onItemSelected: onItemSelected,
        ),
      ));
    }
  }
}

class _CustomDropdownBottomSheet extends StatefulWidget {
  final List<DropdownItem> items;
  final String title;
  final Function(DropdownItem?) onItemSelected;

  const _CustomDropdownBottomSheet({
    required this.items,
    required this.title,
    required this.onItemSelected,
    Key? key,
  }) : super(key: key);

  @override
  _CustomDropdownBottomSheetState createState() =>
      _CustomDropdownBottomSheetState();
}

class _CustomDropdownBottomSheetState
    extends State<_CustomDropdownBottomSheet> {
  late List<DropdownItem> filteredItems;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items; // Initialize with all items
    searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    setState(() {
      filteredItems = widget.items.where((item) {
        return item.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return ListTile(
                  title: Text(item.name),
                  onTap: () {
                    widget.onItemSelected(item);
                    Navigator.pop(context); // Close the BottomSheet
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
