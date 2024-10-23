import 'package:flutter/material.dart';
import 'custom_dropdown_theme.dart';

class CustomDropdownBottomSheet<T> extends StatefulWidget {
  final List<T> items;
  final String title;
  final Function(T?) onItemSelected;
  final ScrollController? scrollController;
  final bool fullScreenMode;
  final bool showSearch;
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
    this.itemBuilder,
    this.itemSearchCondition,
    this.theme,
    Key? key,
  }) : super(key: key);

  @override
  _CustomDropdownBottomSheetState createState() =>
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
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      surfaceTintColor: widget.fullScreenMode ? null : Colors.transparent,
      color: widget.fullScreenMode ? null : Colors.transparent,
      child: Container(
        decoration: widget.theme?.bottomSheetBoxDecoration ??
            BoxDecoration(
              color:
                  widget.theme?.backgroundColor ?? Colors.grey.withOpacity(0.6),
              borderRadius: widget.fullScreenMode
                  ? null
                  : BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
        height:
            widget.fullScreenMode ? MediaQuery.of(context).size.height : 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.fullScreenMode) ...[
              AppBar(
                title: Text(
                  widget.title,
                  style: widget.theme?.titleTextStyle ??
                      Theme.of(context).textTheme.bodyLarge,
                ),
                backgroundColor:
                    widget.theme?.backgroundColor ?? Colors.transparent,
                iconTheme: IconThemeData(
                    color: widget.theme?.backIconColor ?? Colors.black),
              )
            ] else ...[
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title,
                        style: widget.theme?.titleTextStyle ??
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 20.0, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: widget.theme?.backIconColor ?? Colors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              )
            ],
            const SizedBox(height: 10.0),
            if (widget.showSearch)
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                        textAlignVertical: TextAlignVertical(y: 0.2),
                        controller: searchController,
                        decoration: widget.theme?.searchBoxDecoration ??
                            InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                              ),
                              hintText: 'Search here',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black.withOpacity(0.6)),
                              border: InputBorder.none,
                            ))),
              ),
            if (widget.showSearch) const SizedBox(height: 10.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                child: ListView.builder(
                  controller: widget.scrollController,
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return Container(
                      child: widget.itemBuilder != null
                          ? GestureDetector(
                              onTap: () {
                                widget.onItemSelected(item);
                                Navigator.pop(context);
                              },
                              child: widget.itemBuilder!(item),
                            )
                          : ListTile(
                              title: Text(item.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.normal)),
                              onTap: () {
                                widget.onItemSelected(item);
                                Navigator.pop(context);
                              },
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
