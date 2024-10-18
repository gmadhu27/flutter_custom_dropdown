import 'package:flutter/material.dart';
import 'helper/bottom_sheet_mode.dart';

class CustomDropdownHelper {
  static void showDropdown<T>({
    required BuildContext context,
    required List<T> items,
    required String title,
    required Function(T?) onItemSelected,
    BottomSheetMode bottomSheetMode = BottomSheetMode.normal,
    bool showSearch = true,
  }) {
    // Check if the items list is empty
    _checkItemsList(items);
    // Check if the item class has override toString()
    _checkToStringOverride(items);

    _showCustomDropdown(
      context: context,
      items: items,
      title: title,
      onItemSelected: onItemSelected,
      bottomSheetMode: bottomSheetMode,
      showSearch: showSearch,
    );
  }

  static void _checkItemsList<T>(List<T> items) {
    if (items.isEmpty) {
      throw Exception('The items list cannot be empty.');
    }
  }

  static void _checkToStringOverride<T>(List<T> items) {
    if (items.isNotEmpty) {
      final String objectToString = Object().toString();
      final String itemToString = items.first.toString();

      // Check if toString() is overridden by comparing it to the default `Object` implementation.
      if (itemToString == objectToString ||
          itemToString.contains('Instance of')) {
        throw Exception(
            'Class ${items.first.runtimeType} must override toString() to display correctly in the dropdown.');
      }
    }
  }

  static void _showCustomDropdown<T>({
    required BuildContext context,
    required List<T> items,
    required String title,
    required Function(T?) onItemSelected,
    BottomSheetMode bottomSheetMode = BottomSheetMode.normal,
    bool showSearch = true,
  }) {
    // Show the bottom sheet based on the mode
    if (bottomSheetMode == BottomSheetMode.modal) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Allow full-screen modal
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            builder: (context, scrollController) {
              return _CustomDropdownBottomSheet<T>(
                items: items,
                title: title,
                onItemSelected: onItemSelected,
                scrollController: scrollController,
                showSearch: showSearch, // Pass showSearch
              );
            },
          );
        },
      );
    } else if (bottomSheetMode == BottomSheetMode.normal) {
      showBottomSheet(
        context: context,
        builder: (context) {
          return _CustomDropdownBottomSheet<T>(
            items: items,
            title: title,
            onItemSelected: onItemSelected,
            showSearch: showSearch, // Pass showSearch
          );
        },
      );
    } else {
      // Navigate to a full-screen page
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => _CustomDropdownBottomSheet<T>(
          items: items,
          title: title,
          onItemSelected: onItemSelected,
          fullScreenMode: true, // Full-screen mode flag
          showSearch: showSearch, // Pass showSearch
        ),
      ));
    }
  }
}

class _CustomDropdownBottomSheet<T> extends StatefulWidget {
  final List<T> items;
  final String title;
  final Function(T?) onItemSelected;
  final ScrollController? scrollController;
  final bool fullScreenMode;
  final bool showSearch;

  const _CustomDropdownBottomSheet({
    required this.items,
    required this.title,
    required this.onItemSelected,
    this.scrollController,
    this.fullScreenMode = false, // Default is not full-screen mode
    this.showSearch = true, // Default to show search bar
    Key? key,
  }) : super(key: key);

  @override
  _CustomDropdownBottomSheetState<T> createState() =>
      _CustomDropdownBottomSheetState<T>();
}

class _CustomDropdownBottomSheetState<T>
    extends State<_CustomDropdownBottomSheet<T>> {
  late List<T> filteredItems;
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
        return item
            .toString()
            .toLowerCase()
            .contains(searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // Wrap content with Material widget
      child: Container(
        height: widget.fullScreenMode
            ? MediaQuery.of(context).size.height
            : 400, // Set height based on mode
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
            if (widget.showSearch) // Conditionally show the search bar
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
              ),
            if (widget.showSearch) SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                controller:
                    widget.scrollController, // Use the passed scrollController
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return ListTile(
                    title: Text(item.toString()), // Use toString() for display
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
      ),
    );
  }
}
