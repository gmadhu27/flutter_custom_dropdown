## flutter_custom_dropdown

A customizable dropdown package for Flutter that allows developers to display a dropdown using bottom sheets or a full-screen modal. This package supports dynamic item rendering with optional itemBuilder, search functionality, and three different bottom sheet display modes.


## Features
* Customizable Items: Use dynamic items of any type and display them using an optional itemBuilder.
* Multiple Bottom Sheet Modes: Supports modal, non-modal, and full-screen modes for the dropdown.
* Search Functionality: Easily enable or disable search in the dropdown to filter items.
* Generic Support: Allows usage of any class or data model as dropdown items.
* ToString Validation: Automatically checks if your custom class overrides the toString() method to ensure proper display.
* Optional ItemBuilder: Customize the way items are displayed using a builder function or default to a ListTile.


## Getting started
To use the package, add flutter_custom_dropdown to your pubspec.yaml:

```dart
dependencies:
  flutter_custom_dropdown:
    git:
      url:https://github.com/gmadhu27/flutter_custom_dropdown.git

```

Make sure to import the package in your Dart files:
```dart
import 'package:flutter_custom_dropdown/flutter_custom_dropdown.dart';
```

## Usage
Here’s a basic example of how to use the CustomDropdownHelper to show a dropdown with custom items and an optional search bar:

Simple Dropdown Example:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_custom_dropdown/flutter_custom_dropdown.dart';

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

class DropdownExample extends StatelessWidget {
  const DropdownExample({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      DropdownItem(id: "1", name: 'Item 1'),
      DropdownItem(id: "2", name: 'Item 2'),
      DropdownItem(id: "3", name: 'Item 3'),
    ];

    return Center(
      child: ElevatedButton(
        onPressed: () {
          CustomDropdownHelper.showDropdown<DropdownItem>(
            context: context,
            items: items,
            title: "Select an Item",
            onItemSelected: (item) {
              if (item != null) {
                print("Selected: ${item.name}");
              }
            },
            itemBuilder: (item) {
              return ListTile(
                title: Text(item.name),
                subtitle: Text("ID: ${item.id}"),
              );
            },
          );
        },
        child: const Text("Show Dropdown"),
      ),
    );
  }
}
```

Searchable Dropdown Example
```dart
CustomDropdownHelper.showDropdown<DropdownItem>(
  context: context,
  items: myItemsList, // List of DropdownItem or custom class
  title: "Select an Occupation",
  showSearch: true, // Enable search functionality
  onItemSelected: (selectedItem) {
    // Handle the selected item
    print('Selected: ${selectedItem.name}');
  },
);
```
Bottom Sheet Modes
You can display the dropdown using three different modes:

* Modal (default): This displays the dropdown as a modal bottom sheet.
* Non-Modal: Displays a normal bottom sheet that does not cover the screen fully.
* Full-Screen: Displays the dropdown in full-screen mode.
  
```dart
CustomDropdownHelper.showDropdown<DropdownItem>(
  context: context,
  items: myItemsList,
  title: "Choose Item",
  bottomSheetMode: BottomSheetMode.full, // Full-screen mode
  onItemSelected: (selectedItem) {
    print('Selected: ${selectedItem.name}');
  },
);
```
Custom Item Display
You can provide a custom item builder to display items in the dropdown. If not provided, the package defaults to a ListTile using the toString() method of the items.
```dart
CustomDropdownHelper.showDropdown<DropdownItem>(
  context: context,
  items: myItemsList,
  title: "Custom Item Display",
  itemBuilder: (item) {
    return Card(
      child: ListTile(
        title: Text(item.name),
        subtitle: Text("ID: ${item.id}"),
      ),
    );
  },
  onItemSelected: (selectedItem) {
    print('Selected: ${selectedItem.name}');
  },
);
```
Exception Handling
* Empty List: If the items list is empty, an exception will be thrown to notify the developer.
* ToString Check: The package checks if the class used for the items overrides the toString() method. If not, an exception will be thrown, ensuring that the dropdown can display items correctly.


## Additional information
Feel free to contribute to this package, raise issues, or suggest new features by creating an issue in this GitHub repository. This package is open-source, and contributions are always welcome.

For more details and examples, visit the /example folder.

This README provides a concise overview of how to use the package, examples, and additional information for users. You can modify the details based on your specific project requirements, including the repository link or contributing guidelines.
