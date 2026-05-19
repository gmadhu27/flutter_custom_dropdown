# flutter_custom_dropdown_list

A customizable Flutter dropdown package for showing typed item lists in native-feeling bottom sheets or a full-screen selector. It supports custom item rows, searchable lists, custom search logic, and theme control for title, icons, sheet background, and search field styling.

## Features

* Generic item support for any model type.
* Three display modes: normal fixed sheet, draggable modal sheet, and full screen.
* Search can be enabled, disabled, or customized with your own matcher.
* Custom row UI with `itemBuilder`.
* Theme support for title style, icon color, search field decoration, and sheet decoration.
* Keyboard-aware sheets that keep the search field and list usable.
* Scrolling the result list does not dismiss the keyboard.
* Full-screen mode uses an iOS-style back header.

## Getting started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_custom_dropdown_list: ^1.0.2
```

Or use the Git repository:

```yaml
dependencies:
  flutter_custom_dropdown_list:
    git:
      url: https://github.com/gmadhu27/flutter_custom_dropdown.git
```

Import it:

```dart
import 'package:flutter_custom_dropdown_list/flutter_custom_dropdown_list.dart';
```

## Basic usage

```dart
CustomDropdownHelper.showDropdown<Country>(
  context: context,
  items: countries,
  title: 'Select country',
  bottomSheetMode: BottomSheetMode.modal,
  showSearch: true,
  onItemSelected: (country) {
    if (country != null) {
      print('Selected: ${country.name}');
    }
  },
);
```

Your item model should override `toString()` when you do not provide an `itemBuilder`.

```dart
class Country {
  const Country({
    required this.name,
    required this.isoCode,
    required this.dialCode,
  });

  final String name;
  final String isoCode;
  final String dialCode;

  @override
  String toString() => '$name $isoCode $dialCode';
}
```

## Bottom sheet modes

```dart
CustomDropdownHelper.showDropdown<Country>(
  context: context,
  items: countries,
  title: 'Select country',
  bottomSheetMode: BottomSheetMode.normal,
  onItemSelected: (country) {},
);
```

Available modes:

* `BottomSheetMode.normal`: a fixed-height native-style bottom sheet.
* `BottomSheetMode.modal`: a draggable modal sheet. It opens based on the list height and can expand upward, leaving a small top inset.
* `BottomSheetMode.full`: a full-screen selector with an iOS-style back header.

## Custom item rows

Use `itemBuilder` to design each row.

```dart
CustomDropdownHelper.showDropdown<Country>(
  context: context,
  items: countries,
  title: 'Select country code',
  itemBuilder: (country) {
    return ListTile(
      leading: Text(country.flag),
      title: Text(country.name),
      subtitle: Text(country.isoCode),
      trailing: Text(country.dialCode),
    );
  },
  onItemSelected: (country) {
    print(country?.name);
  },
);
```

## Custom search

By default, search matches `item.toString()`. Use `itemSearchCondition` for custom behavior.

```dart
CustomDropdownHelper.showDropdown<Country>(
  context: context,
  items: countries,
  title: 'Select country',
  showSearch: true,
  itemSearchCondition: (country, searchText) {
    return country.name.toLowerCase().contains(searchText) ||
        country.isoCode.toLowerCase().contains(searchText) ||
        country.dialCode.contains(searchText);
  },
  onItemSelected: (country) {},
);
```

Disable the search field with `showSearch: false`.

```dart
CustomDropdownHelper.showDropdown<Country>(
  context: context,
  items: countries,
  title: 'Select country',
  showSearch: false,
  onItemSelected: (country) {},
);
```

## Custom theme

Use `CustomDropdownTheme` to control the visual style.

```dart
CustomDropdownHelper.showDropdown<Country>(
  context: context,
  items: countries,
  title: 'Select country',
  bottomSheetMode: BottomSheetMode.modal,
  showSearch: true,
  itemBuilder: (country) {
    return ListTile(
      title: Text(country.name),
      subtitle: Text(country.isoCode),
      trailing: Text(country.dialCode),
    );
  },
  itemSearchCondition: (country, searchText) {
    return country.name.toLowerCase().contains(searchText) ||
        country.isoCode.toLowerCase().contains(searchText) ||
        country.dialCode.contains(searchText);
  },
  theme: CustomDropdownTheme(
    backgroundColor: const Color(0xFFFEFBFF),
    backIconColor: const Color(0xFF002A86),
    titleTextStyle: const TextStyle(
      color: Color(0xFF20212A),
      fontSize: 20,
      fontWeight: FontWeight.w800,
    ),
    searchBoxDecoration: InputDecoration(
      isDense: true,
      filled: true,
      fillColor: const Color(0xFFFAFAFD),
      hintText: 'Search country / code',
      hintStyle: const TextStyle(
        color: Color(0xFF7E808A),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      prefixIcon: const Icon(
        Icons.search_rounded,
        color: Color(0xFF4F5665),
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
        borderSide: const BorderSide(color: Color(0xFFE2E3EA)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF002A86), width: 1.4),
      ),
    ),
    bottomSheetBoxDecoration: const BoxDecoration(
      color: Color(0xFFFEFBFF),
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
  ),
  onItemSelected: (country) {},
);
```

## Theme properties

| Property | Type | Description |
| -------- | ---- | ----------- |
| `backgroundColor` | `Color?` | Background color for the dropdown surface. |
| `backIconColor` | `Color?` | Color of the close/back icon. |
| `titleTextStyle` | `TextStyle?` | Text style for the sheet title. |
| `searchBoxDecoration` | `InputDecoration?` | Decoration for the search field. |
| `bottomSheetBoxDecoration` | `BoxDecoration?` | Decoration for normal and modal sheet surfaces. |

## Implementation flow

1. Create a list of items for the dropdown.
2. Override `toString()` on the item model, or provide an `itemBuilder`.
3. Call `CustomDropdownHelper.showDropdown<T>()` from a tap or button action.
4. Choose a `BottomSheetMode`: `normal`, `modal`, or `full`.
5. Use `showSearch: true` or `false` depending on the screen.
6. Add `itemSearchCondition` when search should match custom fields.
7. Use `CustomDropdownTheme` to style the title, icon, sheet background, and search field.
8. Read the selected item from `onItemSelected`.

## Exceptions

* Empty list: throws an exception because the dropdown has nothing to show.
* Missing `toString()`: throws an exception when `itemBuilder` is not provided and the first item appears to use the default object string.

## Additional information

Contributions, issues, and feature requests are welcome. For a complete working sample, see the `/example` folder.
