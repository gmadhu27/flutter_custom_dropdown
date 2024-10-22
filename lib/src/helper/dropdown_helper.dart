import 'package:flutter/material.dart';

class CustomDropdownBottomSheet<T> extends StatefulWidget {
  final List<T> items;
  final String title;
  final Function(T?) onItemSelected;
  final ScrollController? scrollController;
  final bool fullScreenMode;
  final bool showSearch;
  final Widget Function(T)? itemBuilder;
  final bool Function(T, String)? itemSearchCondition;

  const CustomDropdownBottomSheet({
    required this.items,
    required this.title,
    required this.onItemSelected,
    this.scrollController,
    this.fullScreenMode = false,
    this.showSearch = true,
    this.itemBuilder,
    this.itemSearchCondition,
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
      child: Container(
        height:
            widget.fullScreenMode ? MediaQuery.of(context).size.height : 400,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            if (widget.showSearch)
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                      textAlignVertical: TextAlignVertical(y: 0.2),
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                        ),
                        hintText: 'Search here',
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.6)),
                        border: InputBorder.none,
                      ))),
            if (widget.showSearch) const SizedBox(height: 10.0),
            Expanded(
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
                            title: Text(item.toString()),
                            onTap: () {
                              widget.onItemSelected(item);
                              Navigator.pop(context);
                            },
                          ),
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
