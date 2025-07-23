import 'package:flutter/material.dart';

import 'category_item.dart';

class SelectedCategoriesWidget extends StatelessWidget {
  final List<int> selectedCategoryIds;
  final void Function(int id) onDelete;
  final VoidCallback onSearch;

  const SelectedCategoriesWidget({
    Key? key,
    required this.selectedCategoryIds,
    required this.onDelete,
    required this.onSearch,
  }) : super(key: key);

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
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedCategoryIds.map((id) {
              return Chip(
                padding: const EdgeInsets.all(0),
                label: CategoryTile(
                  size: 30,
                  id: id,
                  selected: false,
                ),
                backgroundColor: Colors.grey.shade300,
                deleteIcon: const Icon(Icons.close),
                onDeleted: () => onDelete(id),
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
            onPressed: onSearch,
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
