import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/services/storage_service.dart';

class CachedImage extends StatelessWidget {
  final String? userId;

  const CachedImage({
    Key? key,
    this.userId,
  }) : super(key: key);

  Widget errorPlaceholder() {
    return Icon(
      FontAwesomeIcons.exclamationCircle,
      size: 16,
      color: Colors.amber,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (userId != null) {
      return FutureBuilder(
        future: StorageService.instance.getUrlForUserAvatar(userId!),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          String? url = snapshot.data;

          if (url != null) {
            return CachedNetworkImage(
              imageUrl: url,
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
        },
      );
    } else {
      return errorPlaceholder();
    }
  }
}
