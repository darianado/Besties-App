import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/colours.dart';

class CachedImage extends StatelessWidget {
  final String? url;

  const CachedImage({
    Key? key,
    this.url,
  }) : super(key: key);

  Widget errorPlaceholder() {
    return Icon(
      FontAwesomeIcons.exclamationCircle,
      size: 16,
      color: orangeColour,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      return AspectRatio(
        aspectRatio: 1,
        child: CachedNetworkImage(
          imageUrl: url!,
          errorWidget: (context, url, error) {
            return errorPlaceholder();
          },
          placeholder: (context, url) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircularProgressIndicator(),
              ),
            );
          },
          fit: BoxFit.cover,
        ),
      );
    } else {
      return errorPlaceholder();
    }
  }
}
