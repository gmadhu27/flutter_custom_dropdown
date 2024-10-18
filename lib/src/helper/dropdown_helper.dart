import 'package:flutter/material.dart';

class CustomDropdownBottomSheet<T> extends StatefulWidget {
  final List<T> items;
  final String title;
  final Function(T?) onItemSelected;
  final ScrollController? scrollController;
  final bool fullScreenMode;
  final bool showSearch;
  final Widget Function(T)? itemBuilder;

  const CustomDropdownBottomSheet({
    required this.items,
    required this.title,
    required this.onItemSelected,
    this.scrollController,
    this.fullScreenMode = false,
    this.showSearch = true,
    this.itemBuilder,
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
      child: Container(
        height:
            widget.fullScreenMode ? MediaQuery.of(context).size.height : 400,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0),
            if (widget.showSearch)
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                    labelText: 'Search', border: OutlineInputBorder()),
              ),
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
