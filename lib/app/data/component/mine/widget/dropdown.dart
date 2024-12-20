import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDropDownWidget<T> extends StatelessWidget {
  const MyDropDownWidget(
      {super.key,
      required this.items,
      this.selectedValue,
      required this.onChanged,
      required this.dropdownMenuItem,
      required this.searchMatchFn,
      required this.title,
      this.searchController});
  final List<T> items;
  final TextEditingController? searchController;
  final String title;
  final T? selectedValue;
  final String Function(T item) searchMatchFn;
  final void Function(T? value) onChanged;
  final Widget Function(T item) dropdownMenuItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton2<T>(
              hint: Text(
                'Select $title',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: items
                  .map(
                    (item) => DropdownMenuItem<T>(
                      value: item,
                      child: dropdownMenuItem(item),
                    ),
                  )
                  .toList(),
              value: items.isEmpty ? null : selectedValue,
              onChanged: onChanged,
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              dropdownStyleData: const DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: searchController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                    controller: searchController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) =>
                    searchMatchFn(item.value as T)
                        .toLowerCase()
                        .contains(searchValue.toLowerCase()),
              ),
              onMenuStateChange: (isOpen) {
                if (!isOpen) {
                  if (searchController != null) {
                    searchController!.clear();
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MySelectedDropDownWidget<T> extends StatelessWidget {
  const MySelectedDropDownWidget(
      {super.key,
      required this.items,
      this.selectedValue,
      required this.onSelected,
      required this.title,
      required this.selectedItems,
      required this.nameWidget});
  final List<T> items;
  final String title;
  final T? selectedValue;
  final List<T> selectedItems;
  final String Function(T item) nameWidget;
  final void Function(T value) onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton2<T>(
              isExpanded: true,
              hint: Text(
                'Select $title',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              barrierLabel: 'kocak',
              items: items.map((item) {
                return DropdownMenuItem<T>(
                  value: item,
                  //disable default onTap to avoid closing menu when selecting an item
                  enabled: false,
                  child: StatefulBuilder(
                    builder: (context, menuSetState) {
                      final isSelected = selectedItems.contains(item);
                      return InkWell(
                        onTap: () {
                          print(selectedItems.toString());
                          onSelected(item);
                          menuSetState(() {});
                        },
                        child: Container(
                          height: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              if (isSelected)
                                const Icon(Icons.check_box_outlined)
                              else
                                const Icon(Icons.check_box_outline_blank),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  nameWidget(item),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
              onChanged: (value) {},
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              dropdownStyleData: const DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
