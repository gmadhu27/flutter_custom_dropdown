import 'package:flutter/material.dart';
import 'package:flutter_custom_dropdown_list/src/helper/dropdown_helper.dart';
import 'helper/bottom_sheet_mode.dart';
import 'helper/custom_dropdown_theme.dart';

class CustomDropdownHelper {
  static void showDropdown<T>({
    required BuildContext context,
    required List<T> items,
    required String title,
    required ValueChanged<T?> onItemSelected,
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
      theme: theme,
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

      if (itemToString == objectToString ||
          itemToString.contains('Instance of')) {
        throw Exception(
          'Class ${items.first.runtimeType} must override toString() to display correctly in the dropdown.',
        );
      }
    }
  }

  static void _showCustomDropdown<T>({
    required BuildContext context,
    required List<T> items,
    required String title,
    required ValueChanged<T?> onItemSelected,
    BottomSheetMode bottomSheetMode = BottomSheetMode.normal,
    bool showSearch = true,
    Widget Function(T)? itemBuilder,
    bool Function(T, String)? itemSearchCondition,
    CustomDropdownTheme? theme,
  }) {
    // Show the bottom sheet based on the mode
    if (bottomSheetMode == BottomSheetMode.modal) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (context) {
          return AnimatedPadding(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(
              bottom: MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxChildSize =
                    ((constraints.maxHeight - 16) / constraints.maxHeight)
                        .clamp(0.58, 1.0);
                final estimatedSheetHeight =
                    112.0 + (showSearch ? 68.0 : 0.0) + (items.length * 70.0);
                final initialChildSize =
                    (estimatedSheetHeight / constraints.maxHeight).clamp(
                      0.36,
                      maxChildSize,
                    );
                final snapSizes = initialChildSize == maxChildSize
                    ? [maxChildSize]
                    : [initialChildSize, maxChildSize];

                return DraggableScrollableSheet(
                  expand: false,
                  initialChildSize: initialChildSize,
                  minChildSize: 0.36,
                  maxChildSize: maxChildSize,
                  snap: true,
                  snapSizes: snapSizes,
                  builder: (context, scrollController) {
                    return CustomDropdownBottomSheet<T>(
                      items: items,
                      title: title,
                      onItemSelected: onItemSelected,
                      scrollController: scrollController,
                      showSearch: showSearch,
                      showDragHandle: true,
                      useParentHeight: true,
                      itemBuilder: itemBuilder,
                      itemSearchCondition: itemSearchCondition,
                      theme: theme,
                    );
                  },
                );
              },
            ),
          );
        },
      );
    } else if (bottomSheetMode == BottomSheetMode.normal) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black.withValues(alpha: 0.24),
        isScrollControlled: true,
        useSafeArea: true,
        builder: (context) {
          final mediaQuery = MediaQuery.of(context);
          final keyboardHeight = mediaQuery.viewInsets.bottom;
          final availableHeight =
              mediaQuery.size.height -
              keyboardHeight -
              mediaQuery.padding.top -
              16;
          final sheetHeight = availableHeight.clamp(
            260.0,
            mediaQuery.size.height * 0.58,
          );

          return AnimatedPadding(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(bottom: keyboardHeight),
            child: SizedBox(
              height: sheetHeight,
              child: CustomDropdownBottomSheet<T>(
                items: items,
                title: title,
                onItemSelected: onItemSelected,
                showSearch: showSearch,
                showDragHandle: true,
                useParentHeight: true,
                itemBuilder: itemBuilder,
                itemSearchCondition: itemSearchCondition,
                theme: theme,
              ),
            ),
          );
        },
      );
    } else {
      // Navigate to a full-screen page
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CustomDropdownBottomSheet<T>(
            items: items,
            title: title,
            onItemSelected: onItemSelected,
            fullScreenMode: true,
            showSearch: showSearch,
            itemBuilder: itemBuilder,
            itemSearchCondition: itemSearchCondition,
            theme: theme,
          ),
        ),
      );
    }
  }
}
