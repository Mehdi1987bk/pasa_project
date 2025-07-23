import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'category_item.dart';

class CategorySelectorDialog extends StatefulWidget {
  final List<int> initiallySelected;

  const CategorySelectorDialog({super.key, required this.initiallySelected});

  @override
  State<CategorySelectorDialog> createState() => _CategorySelectorDialogState();
}

class _CategorySelectorDialogState extends State<CategorySelectorDialog> {

  late List<Map<String, dynamic>> allItems;
  late Set<int> selectedIds;

  @override
  void initState() {
    super.initState();
    final categories = json.decode(jsonData) as Map<String, dynamic>;
    allItems = categories.values
        .expand((list) => (list as List)
        .map((item) => Map<String, dynamic>.from(item)))
        .toList();
    selectedIds = widget.initiallySelected.toSet();
  }

  void toggleSelection(int id) {
    setState(() {
      if (selectedIds.contains(id)) {
        selectedIds.remove(id);
      } else {
        selectedIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 56, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: allItems.map((item) {
                        return CategoryTile(
                          id: item['id'],
                          selected: selectedIds.contains(item['id']),
                          onTap: () => toggleSelection(item['id']),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (selectedIds.isNotEmpty)
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(selectedIds.toList()),
                    child: const Text('Сhoose'),
                  )
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}