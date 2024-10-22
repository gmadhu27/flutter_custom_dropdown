import 'package:flutter/material.dart';
import 'package:flutter_custom_dropdown_list/src/helper/dropdown_helper.dart';
import 'helper/bottom_sheet_mode.dart';
import 'helper/custom_dropdown_theme.dart';

class CustomDropdownHelper {
  static void showDropdown<T>({
    required BuildContext context,
    required List<T> items,
    required String title,
    required Function(T?) onItemSelected,
    //optional
    BottomSheetMode bottomSheetMode = BottomSheetMode.normal,
    bool showSearch = true,
    Widget Function(T)? itemBuilder,
    bool Function(T, String)? itemSearchCondition,
    CustomDropdownTheme? theme,
  }) {
    // Check if the items list is empty
    _checkItemsList(items);

    // Check if the item class has override toString()
    if (itemBuilder == null) {
      _checkToStringOverride(items);
    }

    _showCustomDropdown(
        context: context,
        items: items,
        title: title,
        onItemSelected: onItemSelected,
        bottomSheetMode: bottomSheetMode,
        showSearch: showSearch,
        itemBuilder: itemBuilder,
        itemSearchCondition: itemSearchCondition,
        theme: theme);
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
    Widget Function(T)? itemBuilder,
    itemSearchCondition,
    theme,
  }) {
    // Show the bottom sheet based on the mode
    if (bottomSheetMode == BottomSheetMode.modal) {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            builder: (context, scrollController) {
              return CustomDropdownBottomSheet<T>(
                items: items,
                title: title,
                onItemSelected: onItemSelected,
                scrollController: scrollController,
                showSearch: showSearch,
                itemBuilder: itemBuilder,
                itemSearchCondition: itemSearchCondition,
                theme: theme,
              );
            },
          );
        },
      );
    } else if (bottomSheetMode == BottomSheetMode.normal) {
      showBottomSheet(
        context: context,
        builder: (context) {
          return CustomDropdownBottomSheet<T>(
              items: items,
              title: title,
              onItemSelected: onItemSelected,
              showSearch: showSearch,
              itemBuilder: itemBuilder,
              itemSearchCondition: itemSearchCondition,
              theme: theme);
        },
      );
    } else {
      // Navigate to a full-screen page
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CustomDropdownBottomSheet<T>(
            items: items,
            title: title,
            onItemSelected: onItemSelected,
            fullScreenMode: true,
            showSearch: showSearch,
            itemBuilder: itemBuilder,
            itemSearchCondition: itemSearchCondition,
            theme: theme),
      ));
    }
  }
}
