import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final VoidCallback onTap;

  const CategoryButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: Colors.green,
        ),
        height: 50,
        child: const Center(
          child: Text(
            "Choose category",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
