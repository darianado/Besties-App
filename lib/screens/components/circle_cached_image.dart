import 'package:flutter/material.dart';
import 'package:project_seg/screens/components/cached_image.dart';

class CircleCachedImage extends StatelessWidget {
  const CircleCachedImage({
    Key? key,
    this.url,
    this.size = 40,
  }) : super(key: key);

  final double size;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(shape: BoxShape.circle),
      clipBehavior: Clip.antiAlias,
      child: CachedImage(url: url),
    );
  }
}
