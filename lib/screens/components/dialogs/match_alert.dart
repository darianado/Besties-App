import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/images/circle_cached_image.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';

import '../../../router/route_names.dart';

/// A widget that displays a [Dialog] when two users match.
class MatchDialog extends StatefulWidget {
  final UserData? otherUser;

  const MatchDialog({
    Key? key,
    required this.otherUser,
  }) : super(key: key);

  @override
  State<MatchDialog> createState() => _MatchDialogState();
}

class _MatchDialogState extends State<MatchDialog> {
  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: whiteColour,
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Text(
                  "It's a match!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 15.0),
                PillButtonFilled(
                  text: "Go to matches",
                  expandsWidth: true,
                  textStyle: Theme.of(context).textTheme.titleLarge?.apply(color: whiteColour),
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.goNamed(homeScreenName, params: {pageParameterKey: chatScreenName});
                  },
                ),
              ],
            ),
            Positioned(
              top: -90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.6)),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CircleCachedImage(
                      url: widget.otherUser?.profileImageUrl,
                      size: 140,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.6)),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: CircleCachedImage(
                      url: _userState.user?.userData?.profileImageUrl,
                      size: 140,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
