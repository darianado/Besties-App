import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/screens/components/buttons/round_action_button.dart';
import 'package:project_seg/screens/components/dialogs/match_alert.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';

/// The [FloatingActionButton] to like the displayed profile.
///
/// The [likeProfile] method is called on-tap
class LikeProfileButton extends StatefulWidget {
  final OtherUser profile;
  final Function onLikeComplete;

  const LikeProfileButton({
    Key? key,
    required this.profile,
    required this.onLikeComplete,
  }) : super(key: key);

  @override
  State<LikeProfileButton> createState() => _LikeProfileButtonState();
}

class _LikeProfileButtonState extends State<LikeProfileButton> with TickerProviderStateMixin {
  late final FirestoreService _firestoreService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firestoreService = Provider.of<FirestoreService>(context, listen: false);
  }

  final notLikedValue = 0.0;
  final likedValue = 1.0;

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    bool isLiked = _userState.user?.userData?.likes?.contains(widget.profile.userData.uid) ?? false;

    final _animationController = AnimationController(vsync: this, value: (isLiked) ? likedValue : notLikedValue);

    return RoundActionButton(
      onPressed: () async {
        if (!isLiked) {
          await _animationController.animateTo(likedValue, duration: const Duration(milliseconds: 600));

          widget.onLikeComplete();

          bool isMatch = await _firestoreService.setLike(widget.profile.userData.uid);

          if (isMatch) {
            showDialog(
              context: context,
              builder: (BuildContext context) => MatchDialog(
                otherUser: widget.profile.userData,
              ),
            );
          }
        }
      },
      child: Transform.scale(
        scale: 1.35,
        child: Lottie.asset("assets/lotties/like.json", controller: _animationController),
      ),
    );
  }
}
