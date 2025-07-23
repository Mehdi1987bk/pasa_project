import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:convert';
import 'package:flutter/painting.dart';
import '../../../../data/network/response/getImages_by_ids_resposne.dart';
import '../../../../data/network/response/get_instances_response.dart';
import '../../../../data/network/response/get_captions_response.dart';
import 'category_item.dart';
import 'clickable_link_text.dart';

class CategoryItem extends StatefulWidget {
  final GetImagesByIdsResponse image;
  final List<GetInstancesResponse> instances;
  final List<GetCaptionsResponse> captions;
  final int id;

  const CategoryItem({
    required this.image,
    required this.instances,
    required this.captions,
    required this.id,
    super.key,
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool showUrls = false;
  bool showCaptions = false;
  Set<int> selectedCategoryIds = {};

  double? originalWidth;
  double? originalHeight;

  @override
  void initState() {
    super.initState();
    _resolveImageSize();
  }

  void _resolveImageSize() {
    final provider = CachedNetworkImageProvider(widget.image.cocoUrl);
    provider.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((info, _) {
        setState(() {
          originalWidth = info.image.width.toDouble();
          originalHeight = info.image.height.toDouble();
        });
      }),
    );
  }

  void toggleUrls() {
    setState(() => showUrls = !showUrls);
  }

  void toggleCaptions() {
    setState(() => showCaptions = !showCaptions);
  }

  void toggleCategory(int categoryId) {
    setState(() {
      if (selectedCategoryIds.contains(categoryId)) {
        selectedCategoryIds.remove(categoryId);
      } else {
        selectedCategoryIds.add(categoryId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final uniqueCategories = widget.instances.map((e) => e.categoryId).toSet().toList();

    if (originalWidth == null || originalHeight == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("🆔 ID: ${widget.image.id}", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                final displayWidth = constraints.maxWidth;
                final displayHeight = displayWidth * originalHeight! / originalWidth!;

                return SizedBox(
                  width: displayWidth,
                  height: displayHeight,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.image.cocoUrl,
                        width: displayWidth,
                        height: displayHeight,
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                      Positioned.fill(
                        child: CustomPaint(
                          painter: SegmentationPainter(
                            instances: widget.instances,
                            selectedCategoryIds: selectedCategoryIds,
                            originalWidth: originalWidth!,
                            originalHeight: originalHeight!,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                CategoryTile(
                  id: -1,
                  selected: showUrls,
                  onTap: toggleUrls,
                  size: 45,
                ),
                CategoryTile(
                  id: -2,
                  selected: showCaptions,
                  onTap: toggleCaptions,
                  size: 45,
                ),
                for (final catId in uniqueCategories)
                  CategoryTile(
                    id: catId,
                    selected: selectedCategoryIds.contains(catId),
                    onTap: () => toggleCategory(catId),
                  ),
              ],
            ),
            if (showUrls) ...[
              const SizedBox(height: 6),
              clickableLinkText("🌐 COCO: ${widget.image.cocoUrl}", widget.image.cocoUrl),
              clickableLinkText("🌐 Flickr: ${widget.image.flickrUrl}", widget.image.flickrUrl)
            ],
            if (showCaptions) ...[
              const SizedBox(height: 12),
              const Text("📝 Captions:", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              for (final caption in widget.captions)
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text("• ${caption.caption}"),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class SegmentationPainter extends CustomPainter {
  final List<GetInstancesResponse> instances;
  final Set<int> selectedCategoryIds;
  final double originalWidth;
  final double originalHeight;

  SegmentationPainter({
    required this.instances,
    required this.selectedCategoryIds,
    required this.originalWidth,
    required this.originalHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (instances.isEmpty) return;

    final scaleX = size.width / originalWidth;
    final scaleY = size.height / originalHeight;

    final paint = Paint()
      ..color = Colors.purple.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    for (final inst in instances) {
      if (!selectedCategoryIds.contains(inst.categoryId)) continue;

      try {
        final List decoded = jsonDecode(inst.segmentation);
        for (final polygon in decoded) {
          final path = Path();
          for (int i = 0; i < polygon.length; i += 2) {
            final x = polygon[i] * scaleX;
            final y = polygon[i + 1] * scaleY;
            if (i == 0) {
              path.moveTo(x, y);
            } else {
              path.lineTo(x, y);
            }
          }
          path.close();
          canvas.drawPath(path, paint);
        }
      } catch (_) {}
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
