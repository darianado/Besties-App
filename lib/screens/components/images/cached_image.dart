import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/colours.dart';

/**
 * This class represents a model of a reusable widget that takes an url
 * to an image and its ratio. It displays the image or shows an error
 * in form of an exclamation mark in a circle.
 */

class CachedImage extends StatelessWidget {
  final String? url;
  final double? aspectRatio;

  const CachedImage({
    Key? key,
    this.url,
    this.aspectRatio,
  }) : super(key: key);

  Widget errorPlaceholder() {
    return const Icon(
      FontAwesomeIcons.exclamationCircle,
      size: 16,
      color: orangeColour,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      if (aspectRatio != null) {
        return AspectRatio(
          aspectRatio: aspectRatio!,
          child: imageWidget,
        );
      } else {
        return imageWidget;
      }
    } else {
      return errorPlaceholder();
    }
  }

  CachedNetworkImage get imageWidget {
    return CachedNetworkImage(
      imageUrl: url!,
      errorWidget: (context, url, error) {
        return errorPlaceholder();
      },
      placeholder: (context, url) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: CircularProgressIndicator(),
          ),
        );
      },
      fit: BoxFit.cover,
    );
  }
}
