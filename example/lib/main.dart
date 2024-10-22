import 'package:flutter/material.dart';
import 'package:flutter_custom_dropdown_list/flutter_custom_dropdown.dart';
import 'dropdown_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Dropdown Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Dropdown Example'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: DropdownExample(),
        ),
      ),
    );
  }
}

class DropdownExample extends StatefulWidget {
  const DropdownExample({super.key});

  @override
  _DropdownExampleState createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  String? _selectedItemName;
  final items = [
    DropdownItem(id: "1", name: 'Option 1'),
    DropdownItem(id: "2", name: 'Option 2'),
    DropdownItem(id: "3", name: 'Option 3'),
    DropdownItem(id: "4", name: 'Option 4'),
    DropdownItem(id: "5", name: 'Option 5'),
    DropdownItem(id: "6", name: 'Option 6'),
    DropdownItem(id: "7", name: 'Option 7'),
    DropdownItem(id: "8", name: 'Option 8'),
    DropdownItem(id: "9", name: 'Option 9'),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            CustomDropdownHelper.showDropdown(
              context: context,
              items: items,
              title: "Select an Item",
              //bottomSheetMode is an optional by deafult normal
              bottomSheetMode: BottomSheetMode.full,
              //showSearch is an optional by deafult true
              showSearch: true,
              onItemSelected: (DropdownItem? selectedItem) {
                // Handle the selected item
                setState(() {
                  _selectedItemName = selectedItem?.name;
                });
              },
              //itemBuilder is an optional
              itemBuilder: (item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.id),
                );
              },
              // Custom search is an optional and handle logic here
              itemSearchCondition: (item, searchText) {
                return item.id.toLowerCase().contains(searchText) ||
                    item.name.toLowerCase().contains(searchText);
              },
            );
          },
          child: const Text('Open Custom Dropdown'),
        ),
        const SizedBox(height: 40),
        Text(
          _selectedItemName ?? 'No item selected',
          style: const TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }
}
