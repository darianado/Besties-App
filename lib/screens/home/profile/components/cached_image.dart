import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/services/storage_service.dart';

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
      color: Colors.orange,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      return CachedNetworkImage(
        imageUrl: url!,
        errorWidget: (context, url, error) {
          return errorPlaceholder();
        },
        placeholder: (context, url) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        },
        fit: BoxFit.cover,
      );
    } else {
      return errorPlaceholder();
    }
  }
}
