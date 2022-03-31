import 'package:flutter/material.dart';
import 'package:project_seg/screens/components/images/cached_image.dart';

/**
 * This class represents a model of a reusable widget that takes an url
 * to an image and displayes it in a circle. It displays the image or shows
 * an error in form of an exclamation mark in a circle.
 */

class CircleCachedImage extends StatelessWidget {
  final double size;
  final String? url;

  const CircleCachedImage({
    Key? key,
    this.url,
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      clipBehavior: Clip.antiAlias,
      child: CachedImage(url: url),
    );
  }
}
