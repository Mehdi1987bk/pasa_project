import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final String jsonData = '''
{
  "outdoor": [
    {"supercategory": "outdoor", "id": 10, "name": "traffic light"},
    {"supercategory": "outdoor", "id": 11, "name": "fire hydrant"},
    {"supercategory": "outdoor", "id": 13, "name": "stop sign"},
    {"supercategory": "outdoor", "id": 14, "name": "parking meter"},
    {"supercategory": "outdoor", "id": 15, "name": "bench"}
  ],
  "food": [
    {"supercategory": "food", "id": 52, "name": "banana"},
    {"supercategory": "food", "id": 53, "name": "apple"},
    {"supercategory": "food", "id": 54, "name": "sandwich"},
    {"supercategory": "food", "id": 55, "name": "orange"},
    {"supercategory": "food", "id": 56, "name": "broccoli"},
    {"supercategory": "food", "id": 57, "name": "carrot"},
    {"supercategory": "food", "id": 58, "name": "hot dog"},
    {"supercategory": "food", "id": 59, "name": "pizza"},
    {"supercategory": "food", "id": 60, "name": "donut"},
    {"supercategory": "food", "id": 61, "name": "cake"}
  ],
  "indoor": [
    {"supercategory": "indoor", "id": 84, "name": "book"},
    {"supercategory": "indoor", "id": 85, "name": "clock"},
    {"supercategory": "indoor", "id": 86, "name": "vase"},
    {"supercategory": "indoor", "id": 87, "name": "scissors"},
    {"supercategory": "indoor", "id": 88, "name": "teddy bear"},
    {"supercategory": "indoor", "id": 89, "name": "hair drier"},
    {"supercategory": "indoor", "id": 90, "name": "toothbrush"}
  ],
  "appliance": [
    {"supercategory": "appliance", "id": 78, "name": "microwave"},
    {"supercategory": "appliance", "id": 79, "name": "oven"},
    {"supercategory": "appliance", "id": 80, "name": "toaster"},
    {"supercategory": "appliance", "id": 81, "name": "sink"},
    {"supercategory": "appliance", "id": 82, "name": "refrigerator"}
  ],
  "sports": [
    {"supercategory": "sports", "id": 34, "name": "frisbee"},
    {"supercategory": "sports", "id": 35, "name": "skis"},
    {"supercategory": "sports", "id": 36, "name": "snowboard"},
    {"supercategory": "sports", "id": 37, "name": "sports ball"},
    {"supercategory": "sports", "id": 38, "name": "kite"},
    {"supercategory": "sports", "id": 39, "name": "baseball bat"},
    {"supercategory": "sports", "id": 40, "name": "baseball glove"},
    {"supercategory": "sports", "id": 41, "name": "skateboard"},
    {"supercategory": "sports", "id": 42, "name": "surfboard"},
    {"supercategory": "sports", "id": 43, "name": "tennis racket"}
  ],
  "animal": [
    {"supercategory": "animal", "id": 16, "name": "bird"},
    {"supercategory": "animal", "id": 17, "name": "cat"},
    {"supercategory": "animal", "id": 18, "name": "dog"},
    {"supercategory": "animal", "id": 19, "name": "horse"},
    {"supercategory": "animal", "id": 20, "name": "sheep"},
    {"supercategory": "animal", "id": 21, "name": "cow"},
    {"supercategory": "animal", "id": 22, "name": "elephant"},
    {"supercategory": "animal", "id": 23, "name": "bear"},
    {"supercategory": "animal", "id": 24, "name": "zebra"},
    {"supercategory": "animal", "id": 25, "name": "giraffe"}
  ],
  "vehicle": [
    {"supercategory": "vehicle", "id": 2, "name": "bicycle"},
    {"supercategory": "vehicle", "id": 3, "name": "car"},
    {"supercategory": "vehicle", "id": 4, "name": "motorcycle"},
    {"supercategory": "vehicle", "id": 5, "name": "airplane"},
    {"supercategory": "vehicle", "id": 6, "name": "bus"},
    {"supercategory": "vehicle", "id": 7, "name": "train"},
    {"supercategory": "vehicle", "id": 8, "name": "truck"},
    {"supercategory": "vehicle", "id": 9, "name": "boat"}
  ],
  "furniture": [
    {"supercategory": "furniture", "id": 62, "name": "chair"},
    {"supercategory": "furniture", "id": 63, "name": "couch"},
    {"supercategory": "furniture", "id": 64, "name": "potted plant"},
    {"supercategory": "furniture", "id": 65, "name": "bed"},
    {"supercategory": "furniture", "id": 67, "name": "dining table"},
    {"supercategory": "furniture", "id": 70, "name": "toilet"}
  ],
  "accessory": [
    {"supercategory": "person", "id": 1, "name": "person"},
    {"supercategory": "accessory", "id": 27, "name": "backpack"},
    {"supercategory": "accessory", "id": 28, "name": "umbrella"},
    {"supercategory": "accessory", "id": 31, "name": "handbag"},
    {"supercategory": "accessory", "id": 32, "name": "tie"},
    {"supercategory": "accessory", "id": 33, "name": "suitcase"}
  ],
  "electronic": [
    {"supercategory": "electronic", "id": 72, "name": "tv"},
    {"supercategory": "electronic", "id": 73, "name": "laptop"},
    {"supercategory": "electronic", "id": 74, "name": "mouse"},
    {"supercategory": "electronic", "id": 75, "name": "remote"},
    {"supercategory": "electronic", "id": 76, "name": "keyboard"},
    {"supercategory": "electronic", "id": 77, "name": "cell phone"}
  ],
  "kitchen": [
    {"supercategory": "kitchen", "id": 44, "name": "bottle"},
    {"supercategory": "kitchen", "id": 46, "name": "wine glass"},
    {"supercategory": "kitchen", "id": 47, "name": "cup"},
    {"supercategory": "kitchen", "id": 48, "name": "fork"},
    {"supercategory": "kitchen", "id": 49, "name": "knife"},
    {"supercategory": "kitchen", "id": 50, "name": "spoon"},
    {"supercategory": "kitchen", "id": 51, "name": "bowl"}
  ]
}
''';

final Map<String, dynamic> categoryMap = jsonDecode(jsonData);


final List<Map<String, dynamic>> allCategories = categoryMap.values
    .expand((list) => List<Map<String, dynamic>>.from(list))
    .toList();

class CategoryTile extends StatelessWidget {
  final int id;
  final bool selected;
  final VoidCallback? onTap;
  final double? size;

  const CategoryTile({
    super.key,
    required this.id,
    required this.selected,
    this.onTap,
    this.size = 45,
  });

  String _resolveImageId() {
    if (id == -1) return 'url';
    if (id == -2) return 'sentences';
    return id.toString();
  }

  @override
  Widget build(BuildContext context) {
    final imageId = _resolveImageId();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: size != null
              ? null
              : Border.all(
            color: selected ? Theme.of(context).colorScheme.primary : Colors.black26,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: selected ? Colors.green : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CachedNetworkImage(
            imageUrl: "https://cocodataset.org/images/cocoicons/$imageId.jpg",
            fit: BoxFit.contain,
            placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 2),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

