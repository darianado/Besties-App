import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/colours.dart';

/// A widget that displays and image from its [url].
class CachedImage extends StatelessWidget {
  final String? url;

  const CachedImage({
    Key? key,
    this.url,
  }) : super(key: key);

  /// Returns an exclamation mark [Icon].
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
      return imageWidget;
    } else {
      return errorPlaceholder();
    }
  }

  CachedNetworkImage get imageWidget {
    return CachedNetworkImage(
      imageUrl: url!,
      errorWidget: (context, url, error) => errorPlaceholder(),
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
