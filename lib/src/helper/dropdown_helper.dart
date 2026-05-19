import 'package:flutter/material.dart';
import 'custom_dropdown_theme.dart';

class CustomDropdownBottomSheet<T> extends StatefulWidget {
  final List<T> items;
  final String title;
  final ValueChanged<T?> onItemSelected;
  final ScrollController? scrollController;
  final bool fullScreenMode;
  final bool showSearch;
  final bool showDragHandle;
  final bool useParentHeight;
  final Widget Function(T)? itemBuilder;
  final bool Function(T, String)? itemSearchCondition;
  final CustomDropdownTheme? theme;

  const CustomDropdownBottomSheet({
    required this.items,
    required this.title,
    required this.onItemSelected,
    this.scrollController,
    this.fullScreenMode = false,
    this.showSearch = true,
    this.showDragHandle = false,
    this.useParentHeight = false,
    this.itemBuilder,
    this.itemSearchCondition,
    this.theme,
    super.key,
  });

  @override
  State<CustomDropdownBottomSheet<T>> createState() =>
      _CustomDropdownBottomSheetState<T>();
}

class _CustomDropdownBottomSheetState<T>
    extends State<CustomDropdownBottomSheet<T>> {
  late List<T> filteredItems;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
    searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    setState(() {
      final searchText = searchController.text.toLowerCase();

      filteredItems = widget.items.where((item) {
        if (widget.itemSearchCondition != null) {
          return widget.itemSearchCondition!(item, searchText);
        } else {
          return item.toString().toLowerCase().contains(searchText);
        }
      }).toList();
    });

    // Reset scroll position after filtering items
    if (widget.scrollController != null &&
        widget.scrollController!.hasClients) {
      widget.scrollController!.jumpTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        widget.theme?.backgroundColor ??
        (isDarkMode
            ? const Color(0xFF2C2C2C)
            : Colors.grey.withValues(alpha: 0.6));
    final searchBoxColor = isDarkMode ? const Color(0xFF3C3C3C) : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final hintTextColor = isDarkMode
        ? Colors.grey.shade400
        : Colors.black.withValues(alpha: 0.6);
    final decoration = widget.fullScreenMode
        ? BoxDecoration(color: backgroundColor)
        : widget.theme?.bottomSheetBoxDecoration ??
              BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              );

    return Material(
      surfaceTintColor: widget.fullScreenMode ? null : Colors.transparent,
      color: widget.fullScreenMode ? null : Colors.transparent,
      elevation: widget.fullScreenMode ? 0 : 18,
      shadowColor: Colors.black.withValues(alpha: 0.24),
      clipBehavior: Clip.antiAlias,
      borderRadius: widget.fullScreenMode
          ? BorderRadius.zero
          : const BorderRadius.vertical(top: Radius.circular(25.0)),
      child: Container(
        constraints: widget.useParentHeight
            ? const BoxConstraints.expand()
            : null,
        decoration: decoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showDragHandle) ...[
              const SizedBox(height: 10.0),
              Center(
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5C5D66),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
            ],
            if (widget.fullScreenMode) ...[
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 6, 20, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: widget.theme?.backIconColor ?? textColor,
                          size: 18,
                        ),
                        style: IconButton.styleFrom(
                          minimumSize: const Size.square(36),
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          widget.title,
                          style:
                              widget.theme?.titleTextStyle ??
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: textColor,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              const SizedBox(height: 2.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style:
                          widget.theme?.titleTextStyle ??
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: widget.theme?.backIconColor ?? textColor,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: widget.fullScreenMode ? 2.0 : 10.0),
            if (widget.showSearch)
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: SizedBox(
                  height: 48,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: searchController,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration:
                        widget.theme?.searchBoxDecoration ??
                        InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: searchBoxColor,
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: hintTextColor,
                            size: 19,
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 44,
                            minHeight: 44,
                          ),
                          hintText: 'Search here',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: hintTextColor,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 13,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: hintTextColor.withValues(alpha: 0.16),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: hintTextColor.withValues(alpha: 0.32),
                            ),
                          ),
                        ),
                  ),
                ),
              ),
            if (widget.showSearch) const SizedBox(height: 10.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: ListView.builder(
                  key: ValueKey<int>(filteredItems.length),
                  controller: widget.scrollController,
                  padding: EdgeInsets.only(
                    bottom: mediaQuery.padding.bottom + 16,
                  ),
                  physics: const BouncingScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.manual,
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        widget.onItemSelected(item);
                        Navigator.pop(context);
                      },
                      child: widget.itemBuilder != null
                          ? widget.itemBuilder!(item)
                          : ListTile(
                              title: Text(
                                item.toString(),
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal,
                                      color: textColor,
                                    ),
                              ),
                            ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
