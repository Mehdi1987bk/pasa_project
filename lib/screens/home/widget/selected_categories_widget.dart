import 'package:flutter/material.dart';

import 'category_item.dart';

import 'dart:convert';

class SelectedCategoriesWidget extends StatefulWidget {
  final List<int> selectedCategoryIds;
  final void Function(int id) onDelete;
  final void Function(int id) onAdd;
  final VoidCallback onSearch;

  const SelectedCategoriesWidget({
    Key? key,
    required this.selectedCategoryIds,
    required this.onDelete,
    required this.onAdd,
    required this.onSearch,
  }) : super(key: key);

  @override
  State<SelectedCategoriesWidget> createState() => _SelectedCategoriesWidgetState();
}

class _SelectedCategoriesWidgetState extends State<SelectedCategoriesWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];


  late final List<Map<String, dynamic>> allCategories;

  @override
  void initState() {
    super.initState();
    final decoded = jsonDecode(jsonData) as Map<String, dynamic>;
    allCategories = decoded.values
        .expand((list) => List<Map<String, dynamic>>.from(list))
        .toList();
  }

  void _onSearchTextChanged(String text) {
    if (text.length < 1) {
      setState(() => _searchResults = []);
      return;
    }
    setState(() {
      _searchResults = allCategories
          .where((item) =>
      item['name'].toLowerCase().contains(text.toLowerCase()) &&
          !widget.selectedCategoryIds.contains(item['id']))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Search category',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: _onSearchTextChanged,
          ),
          const SizedBox(height: 12),
          if (_searchResults.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _searchResults.map((item) {
                return ActionChip(
                  label: Text(item['name']),
                  onPressed: () {
                    widget.onAdd(item['id']);
                    _searchController.clear();
                    _onSearchTextChanged('');
                  },
                );
              }).toList(),
            ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.selectedCategoryIds.map((id) {
               return Chip(
                padding: const EdgeInsets.all(0),
                label: CategoryTile(
                  size: 30,
                  id: id,
                  selected: false,
                ),
                backgroundColor: Colors.grey.shade300,
                deleteIcon: const Icon(Icons.close),
                onDeleted: () => widget.onDelete(id),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: widget.onSearch,
            child: const Text(
              'Search',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}



